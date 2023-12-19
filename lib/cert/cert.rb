# Certificate management.

class Cert
  def self.load 
    public_key_raw = read_certificates('./utils/localhost.crt')
    private_key_raw = read_certificates('./utils/localhost.key')
    certificate = OpenSSL::X509::Certificate.new(public_key_raw)
    rsa_key = OpenSSL::PKey::RSA.new(private_key_raw)
    context = OpenSSL::SSL::SSLContext.new
    context.add_certificate(certificate, rsa_key)
    context.min_version = OpenSSL::SSL::TLS1_1_VERSION
    context.max_version = OpenSSL::SSL::TLS1_3_VERSION
    context.ecdh_curves = 'X25519:P-256:P-224'
    context.ciphers = [['TLS_AES_256_GCM_SHA384', 'TLSv1.3', 256, 256],
                       ['TLS_CHACHA20_POLY1305_SHA256', 'TLSv1.3', 256, 256], ['TLS_AES_128_GCM_SHA256', 'TLSv1.3', 128, 128], ['PSK-AES128-CBC-SHA256', 'TLSv1.0', 128, 128]]
    context
  end
end
