module DocuSign
  class RequestNoficiationToken < DocuSignModel
    ATTRIBUTES = [:envelope_id, :username, :email, :client_user_id,
                  :authentication_assertion, :client_urls]
    ATTRIBUTES.each do |attr|
      self.send(:attr_accessor, attr)
    end

    def initialize(attributes = {})
      ATTRIBUTES.each do |attr|
        self.send("#{attr}=", attributes[attr])
      end
    end

    def to_savon
      { "EnvelopeId" => envelope_id,
        "Username" => username,
         "Email" => "donald@donaldpiret.com",
          "ClientUserId" => 1,
          'AuthenticationAssertion' => {
            'AssertionId' => Time.now.to_i.to_s,
            'AuthenticationInstant' => DateTime.now,
            'AuthenticationMethod' => 'Password',
            'SecurityDomain' => 'https://demo.example.com',
          },
         "ClientURLs" =>
          client_urls.to_savon
          #{
           #'OnSigningComplete' => 'https://demo.example.com',
           #'OnDecline' => 'https://demo.example.com',
           #'OnViewingComplete' => 'https://demo.example.com',
           #'OnException' => 'https://demo.example.com',
           #'OnCancel' => 'https://demo.example.com',
           #'OnTTLExpired' => 'https://demo.example.com',
           #'OnSessionTimeout'=> 'https://demo.example.com'
         #}
      }
    end

  end
end
