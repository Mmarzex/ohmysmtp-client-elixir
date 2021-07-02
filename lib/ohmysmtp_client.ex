defmodule OhmysmtpClient do
  @moduledoc """
  A Thin Client for interacting with OhMySmtp

  An API key created in the OhMySmtp dashboard must be in your application config under,

      config: :ohmysmtp_client, token: "<OhMySmtp_API_TOKEN>"
  """

  alias OhmysmtpClient.EmailSendRequest

  @doc """
  Send Email

  ## Examples

      iex> OhmysmtpClient.send_email(%OhmysmtpClient.EmailSendRequest{
                                      from: "elixir@example.com",
                                      subject: "Test",
                                      textbody: "from elixir",
                                      to: "hex@example.com"
                                    })
      :ok
  """
  def send_email(%EmailSendRequest{} = email_send_request) do
    call_ohmysmtp_send(email_send_request, Application.get_env(:ohmysmtp_client, :token))
  end

  def send_email(_), do: :error

  defp call_ohmysmtp_send(%EmailSendRequest{} = email_send_request, token) when is_binary(token) do
    HTTPoison.start()
    body = Jason.encode!(email_send_request)

    headers = [
      {"Content-Type", "application/json"},
      {"OhMySMTP-Server-Token", token},
      {"Accept", "application/json"}
    ]

    case HTTPoison.post("https://app.ohmysmtp.com/api/v1/send", body, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        IO.puts body
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  defp call_ohmysmtp_send(_, _), do: {:error, "Token was not set in the :ohmysmtp_client config"}
end
