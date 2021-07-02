defmodule OhmysmtpClient.EmailSendRequest do
  @moduledoc """
  OhMySmtpCleint.EmailSendRequest to be used when calling send_email

  ## Examples

      iex> %OhmysmtpClient.EmailSendRequest{
                                      from: "elixir@example.com",
                                      subject: "Test",
                                      textbody: "from elixir",
                                      to: "hex@example.com"
          }
  """

  @type t :: %__MODULE__{from: String.t, to: String.t, subject: String.t, textbody: String.t}
  @derive Jason.Encoder
  defstruct [:from, :to, :subject, :textbody]
end
