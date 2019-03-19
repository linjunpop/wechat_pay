defmodule WechatPay.Client do
  alias WechatPay.Client

  @enforce_keys [:app_id, :mch_id, :api_key]
  defstruct api_host: "https://api.mch.weixin.qq.com/",
            app_id: nil,
            mch_id: nil,
            api_key: nil,
            ssl: nil

  @type t :: %Client{
          api_host: String.t(),
          app_id: String.t(),
          mch_id: String.t(),
          api_key: String.t(),
          ssl:
            keyword() :: [
              {:ca_cert, String.t() | nil},
              {:cert, String.t()},
              {:key, String.t()}
            ]
        }

  @doc """
  Build a new Config from keyword list
  """
  @spec new(Enum.t()) :: Client.t()
  def new(opts) do
    struct(Client, opts)
  end
end