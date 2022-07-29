class XxxPayDepositService
  attr_reader :url, :auth_key, :pay_key, :merchant_id, :datetime, :notify_url, :errors

  Request_Content_Type = 'application/x-www-form-urlencoded;charset=utf-8'

  def initialize
    @url = 'https://gwy-mgt.harugame.com/api'
    @auth_key = '65a9fea3ddf09051ed534d7e6a069b99'
    @pay_key = '09e53280131401830e299fe7fd94de56'
    @merchant_id = 'X9N220726214357M6655'
    @notify_url = 'https://localhost:3000/api/xxx_pay/callback'
    @datetime = Time.current.strftime('%y%m%d%H%M%S')
    @errors = {}
  end

  def deposit(order)
    params = {
      merchantNo: merchant_id,
      merchantUser: order.user.email,
      merchantOrder: order.id,
      channel: '007002001',
      amount: order.amount,
      currency: :PHP,
      dateTime: datetime
    }
    params = params.merge({ signature: sign(params, pay_key) }, # 签名字串
                          { payerName: '09111111111' },
                          { getPayInfo: :N },
                          {callbackUrl: notify_url})
    # raw_response = RestClient.post "#{url}/transaction/deposit",
    #                                generate_query_string(params),
    #                                {
    #                                  Authorization: "Bearer #{auth_token}",
    #                                  'Content-Type': Request_Content_Type
    #                                }
    # response = JSON.parse(raw_response)
    # { url: response['data']['pageUrl'] } if validate_response(response)
    # { url: "http://cashier-pay.harugame.com/PKLR789395986049QY4Q" }
  end

  def balance_query
    params = {
      merchantNo: merchant_id,
      dateTime: datetime
    }
    params[:signature] = sign(params, pay_key)
    raw_response = RestClient.post "#{url}/get/balance",
                                   generate_query_string(params),
                                   {
                                     Authorization: "Bearer #{auth_token}",
                                     'Content-Type': Request_Content_Type
                                   }
    response = JSON.parse(raw_response)
    response['data']['balance']
  end

  def transition_query(order)
    params = {
      merchantNo: merchant_id,
      merchantOrder: order.id,
      dateTime: datetime
    }
    params[:signature] = sign(params, pay_key)
    raw_response = RestClient.post "#{url}/transaction/deposit/verify",
                                   generate_query_string(params),
                                   {
                                     Authorization: "Bearer #{auth_token}",
                                     'Content-Type': Request_Content_Type
                                   }
    response = JSON.parse(raw_response)
    response['data']['isSuccess'] == true
  end

  def auth_token
    params = {
      merchantNo: merchant_id,
      dateTime: datetime
    }
    params[:signature] = sign(params, auth_key)
    raw_response = RestClient.post "#{url}/get/auth",
                                   generate_query_string(params),
                                   {
                                     'Content-Type': Request_Content_Type
                                   }
    JSON.parse(raw_response)['data']['auth_token']
  rescue StandardError => e
    e.http_body
  end

  def sign(params, key)
    Digest::MD5.hexdigest((params.values << key).join).downcase
  end

  def generate_query_string(params)
    params.map { |key, value| "#{key}=#{value}" }.join('&')
  end

  def validate_response(response)
    self.errors = {}
    if response['code'] == '0'
      true
    else
      errors['msg'] = response['message']
      errors['success'] = 'false'
      false
    end
  end
end