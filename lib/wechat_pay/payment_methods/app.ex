defmodule WechatPay.App do
  @moduledoc """
  The **App** payment method.

  [Official document](https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=8_1)
  """

  alias WechatPay.Utils.NonceStr
  alias WechatPay.Utils.Signature
  alias WechatPay.Client
  alias WechatPay.API

  @doc """
  Place an order

  [Official document](https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=9_1)
  """
  @spec place_order(Client.t(), map, keyword) ::
          {:ok, map} | {:error, WechatPay.Error.t() | HTTPoison.Error.t()}
  defdelegate place_order(client, attrs, options \\ []), to: API

  @doc """
  Query the order

  [Official document](https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=9_2&index=4)
  """
  @spec query_order(Client.t(), map, keyword) ::
          {:ok, map} | {:error, WechatPay.Error.t() | HTTPoison.Error.t()}
  defdelegate query_order(client, attrs, options \\ []), to: API

  @doc """
  Close the order

  [Official document](https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=9_3&index=5)
  """
  @spec close_order(Client.t(), map, keyword) ::
          {:ok, map} | {:error, WechatPay.Error.t() | HTTPoison.Error.t()}
  defdelegate close_order(client, attrs, options \\ []), to: API

  @doc """
  Request to refund

  [Official document](https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=9_4&index=6)
  """
  @spec refund(Client.t(), map, keyword) ::
          {:ok, map} | {:error, WechatPay.Error.t() | HTTPoison.Error.t()}
  defdelegate refund(client, attrs, options \\ []), to: API

  @doc """
  Query the refund

  [Official document](https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=9_5&index=7)
  """
  @spec query_refund(Client.t(), map, keyword) ::
          {:ok, map} | {:error, WechatPay.Error.t() | HTTPoison.Error.t()}
  defdelegate query_refund(client, attrs, options \\ []), to: API

  @doc """
  Download bill

  [Official document](https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=9_6&index=8)
  """
  @spec download_bill(Client.t(), map, keyword) ::
          {:ok, String.t()} | {:error, HTTPoison.Error.t()}
  defdelegate download_bill(client, attrs, options \\ []), to: API

  @doc """
  Report

  [Official document](https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=9_8&index=9)
  """
  @spec report(Client.t(), map, keyword) ::
          {:ok, map} | {:error, WechatPay.Error.t() | HTTPoison.Error.t()}
  defdelegate report(client, attrs, options \\ []), to: API

  @doc """
  Generate pay request info, which is required for the App SDK

  [Official document](https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=9_12&index=2)
  """
  @spec generate_pay_request(Client.t(), String.t()) :: map
  def generate_pay_request(client, prepay_id) do
    %{
      "appid" => client.app_id,
      "partnerid" => client.mch_id,
      "prepayid" => prepay_id,
      "package" => "Sign=WXPay",
      "noncestr" => NonceStr.generate(),
      "timestamp" => Integer.to_string(:os.system_time())
    }
    |> sign(client.api_key)
  end

  defp sign(data, api_key) do
    data
    |> Map.merge(%{"sign" => Signature.sign(data, api_key)})
  end
end
