#module Hippo
  module EncDec
    def self.encrypt_file(file)
      #file = self.to_s
      ext_file = file + ".x1"
      File.rename(file, ext_file)

      key = "1234567890123456"
      alg = "bf"
      iv = "6543210987654321"

      blow = OpenSSL::Cipher::Cipher.new alg
      blow.encrypt
      blow.key = key
      blow.iv = iv
      File.open(file,'wb') do |enc|
        File.open(ext_file) do |f|
          loop do
            r = f.read(4096)
            break unless r
            cipher = blow.update(r)
            enc << cipher
          end
        end

        enc << blow.final
      end
      File.unlink(ext_file)
      return file
    end

    def self.decrypt_file(file)
      FileUtils.cp(file, file + '.x1')

      key = "1234567890123456"
      alg = "bf"
      iv = "6543210987654321"

      blow = OpenSSL::Cipher::Cipher.new alg
      blow.decrypt
      blow.key = key
      blow.iv = iv

      File.open(file + '.x2','wb') do |dec|
        File.open(file + '.x1', 'rb') do |f|
          loop do
            r = f.read(4096)
            break unless r
            cipher = blow.update(r)
            dec << cipher
          end
        end

        dec << blow.final
      end
      return file + '.x2'
    end
  end
#end
