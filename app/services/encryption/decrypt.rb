class Encryption::Encrypt
  def self.call(key, iv, encrypted)
    decipher = OpenSSL::Cipher::AES.new(256, :CBC)
    decipher.decrypt
    decipher.key = key
    decipher.iv = iv
    plain = decipher.update(encrypted) + decipher.final

    plain
  end
end

