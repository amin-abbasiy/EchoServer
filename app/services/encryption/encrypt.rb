class Encryption::Encrypt
  def self.call(**payload)
    cipher = ::OpenSSL::Cipher::AES.new(256, :CBC)
    cipher.encrypt

    key = cipher.random_key
    iv = cipher.random_iv

    encrypted = cipher.update(payload.to_json) + cipher.final

    encrypted

  end
end