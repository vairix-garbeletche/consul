Rails.application.config.middleware.use OmniAuth::Builder do
  provider :saml,
           assertion_consumer_service_url:      "https://maquetasaml.gub.uy:8443/maqueta/acs",
           issuer:                              "https://maquetasaml.gub.uy",
           idp_entity_id:                       "https://test-eid.portal.gub.uy/idp",
           idp_sso_target_url:                  "https://test-eid.portal.gub.uy/v1.1/idp/profile/SAML2/Redirect/SSO",
           idp_slo_target_url:                  "https://test-eid.portal.gub.uy/v1.1/idp/profile/SAML2/Redirect/SLO",
           allowed_clock_drift:                 2.seconds,
           idp_cert:                            "-----BEGIN CERTIFICATE-----
MIIGmDCCBICgAwIBAgIUAS/11GjKMHiiDP60udGLq+2m8w8wDQYJKoZIhvcNAQELBQAwWjEdMBsG
A1UEAxMUQ29ycmVvIFVydWd1YXlvIC0gQ0ExLDAqBgNVBAoMI0FkbWluaXN0cmFjacOzbiBOYWNp
b25hbCBkZSBDb3JyZW9zMQswCQYDVQQGEwJVWTAeFw0xNzAyMTQyMzQzMDJaFw0xOTAyMTQyMzQz
MDJaMIHDMRgwFgYDVQQFEw9SVUMyMTU5OTYwNjAwMTUxCzAJBgNVBAYTAlVZMXoweAYDVQQKE3FB
R0VOQ0lBIFBBUkEgRUwgREVTQVJST0xMTyBERUwgR09CSUVSTk8gREUgR0VTVElPTiBFTEVDVFJP
TklDQSBZIExBIFNPQ0lFREFEIERFIExBIElORk9STUFDSU9OIFkgREVMIENPTk9DSU1JRU5UTzEe
MBwGA1UEAxMVQUdFU0lDLUNPRVNZUy1URVNUSU5HMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAtE5SpOUpKpvPrHuBYnq7SLDY406Yz7r9N5JEY5cl1qKp6AGew1ENz8/UWVcRlJvz24d7
WZojrXdxUouulwS0xgqYafljiDoZrstPb9XzsZS/7jsqwI6htjl+2dg3Vrz47wCR+uFZ9tQ5wfTU
KHVGloW+9h0fWYY6EE/Tj5JI716R/b/vhlbKJxA6U2m3Tfsnlf0ME3V5qoCVYtHHKqXG5shkAcWu
7SSPUZGCOUATJE878y+vJX7nXsrmiIXRkydNdR/2djCxLNGvCVH58oTtxrFMW/z0xKqCkf7SYXwl
qVJbOU9cSHblR1hyWdqxiMqVv9CEH90587bAIvHrXon3awIDAQABo4IB6jCCAeYweQYIKwYBBQUH
AQEEbTBrMDYGCCsGAQUFBzAChipodHRwOi8vYW5jY2EuY29ycmVvLmNvbS51eS9hbmNjYS9hbmNj
YS5jZXIwMQYIKwYBBQUHMAGGJWh0dHA6Ly9hbmNjYS5jb3JyZW8uY29tLnV5L2FuY2NhL09DU1Aw
DgYDVR0PAQH/BAQDAgTwMAwGA1UdEwEB/wQCMAAwOwYDVR0fBDQwMjAwoC6gLIYqaHR0cDovL2Fu
Y2NhLmNvcnJlby5jb20udXkvYW5jY2EvYW5jY2EuY3JsMIG4BgNVHSAEgbAwga0wZAYLYIZahOKu
HYSIBQQwVTBTBggrBgEFBQcCARZHaHR0cDovL3VjZS5ndWIudXkvaW5mb3JtYWNpb24tdGVjbmlj
YS9wb2xpdGljYXMvY3BfcGVyc29uYV9qdXJpZGljYS5wZGYwRQYLYIZahOKuHYSIBQYwNjA0Bggr
BgEFBQcCARYoaHR0cDovL2FuY2NhLmNvcnJlby5jb20udXkvYW5jY2EvY3BzLnBkZjATBgNVHSUE
DDAKBggrBgEFBQcDAjAdBgNVHQ4EFgQUZw14WKgKszHgagvubQARyECWjyQwHwYDVR0jBBgwFoAU
bOKwJo1b1iYIH5hdaeAOf1XsrnYwDQYJKoZIhvcNAQELBQADggIBAKLbYOqvoUHHPDfi2nyzKv2e
IO0VQNuhfPUdRD7eLY31XMbfSwIY5+z7fhZD1j+SHY4gNlGR/j54OYj3n9sEAfzUqBqqUmCrs0oo
fkCNsR1ZlCPh7Pu3NANcytkXMEV8Jgs5ZVc/Uo7Lgf0Ckbij/8faLGwNknd/yvj+QMecwPNtP0y8
xHkQlRLtRPjLLXz1hrbk5GgKKtuPl19yCHC8uTQs3ZkSEPU3QJnIsLP390EPkVZ7Jv5NgwECvg3Q
pjCBulN18aDGtsOUuG3V7mMgcR7s6dyoVPlcJti9O3ZSUJLoLRxuOddKZLSd1Ne5IhMJf7KQh5ya
BeQvoA5kNN+0oP3oMKd7H9QQlFj0fq3qwDDuungCmD4BaN1ijhoy3mVp/opma+1KRoOQ2VoE7Gnj
2DCC4Ce7LD9IkAzzPlq15JYU7SS3aMqpeyJVeF7wlI/NZYDiiRDzL4mtg17bhqMdUBofCXGLH2G5
inkfEzm/SZU8NqNWiOAUjyeqA/c+uILo0w/eQHD7PUgG3DmIg7JpuY9UF5CmzJCue0hKx5L17UsO
LPjT3ffMuJ0p69aG+W3a+GJiig1khvTVVtBYwZYfKnc2sw8OX/9M2xSUJ3k5zdQnIJSJx8CMtr4y
AOhcG9m5AXoV87GoKQmhpW1fdqHlX8zF1IWABgYR7cIkmO7tM9PL
-----END CERTIFICATE-----",
           name_identifier_format:              "urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified",
           private_key:                         "-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEA98nVb2tUJaW8FgX36pTB0PD3ipvfoHhqSaI2+RytgcOzduxm
BUYIzeowi5RkG/ox7pRU1WwY4HHvJ9pCzNmcR2kECCyV+TYLOgjqp1zYx3igQ4sj
9NsaDw+suUH2hwjTFnhABdCgHWb2SsCwQMMA5p3mq7l2PV9jcCnOkCUletB4Jjxu
jSRLxXQlJqzHmLYwV5VJQUiJGIALjU8TZgMXcM1sXb8tHGLG/4RCILVphU64b7hC
9fF/FvHovZmikl80bBn/TbD+2tLaWL0eTG1HJkkO993xPwHQfNgySNGnfzdUKzl4
e4Zobrlhurhf6b8uf31a6T22AIIN49WPOJ+ZeQIDAQABAoIBAGf2lgeGh6q4C99N
p8QTn/IzeBj+52fjveyhE+GXR7EfVCf8bZ2e0cjbjnyxyQL4CYUpVSKqlRFunEIj
UE20q95GUHvBgTcrlrBF13Za/VVL5ioQsghk+V0CXZzo8S+c4zwVPf9ylgtgDMw2
Znz1lGYuL/8y9EoxwH3p/JH8E+qfw8Bjo2GJOnSgVdaja2EBi0FdTLTofKjZGe/i
S14VNs+6yzibvJiPFPfnhkb6QJ/EGL85hyI10Rj4NWh48gaXXJ9HerYJWkVOS2DQ
kX072ZxngO4zlEmjXTRax+pqRlR9hT0tHlmfbezjRse1wQH6L0zmCbXm3cZNtgev
Gn3F/QECgYEA/LTpCz2xx0e7nwT0zWhW0CDePRe0TqPGJqPwVYBtaBrI818LgKDn
Bsftv1R3llbB9n3EIRH0zWhmWwcWCfXrUmOGmF6Wg5WtOKZW3ecGTuBh7zq2vmX4
mkzS/Ey1vkjLvTgwMXCSsg2bTvwKfrEsCtL02cJCSGijMNbpn6pmvZkCgYEA+wSD
z9rxvX+MKpEq5EwD1iCIfw53V9Xl4IuYtqZpBBiCX6iL6Ixkv/5rVpka/+El8PoP
aFx4Oh02JgBXA8P2Dguz+m3g6g3i4ZAtDCPrzG3tCGRSFfJ71tOnqRCxIF4qoFFy
WxSeMaktAn1ROmxy6hvZ3B8z7MInDQpXa1gIZuECgYAhFX49HoKb2GRT2U5DZhmX
ffYagXP1p7NVc7kPOJUaQAd29UaIPIiCdsJFfkV5xTn3j1eSDMvD6Jsd57uW6j84
thb08804xOu8supEeu50fSPVMhairq7xZIVqypAwrU8fIrAMiPRroyRmHtEw7Pkb
Ias0px4OZMSYrEpBwQlaYQKBgQCmxuYo+Og6pn7jXVYpHtRBtZXbDSp/4m78VOOf
H0uQ3BPrKJnkZTsfURPSEqGctuO1iv8nsKB0xCnQ79LgfpeB14a58b1I5PcENP2p
Hkixp6ugMr9TM6vSHQg9TQjSX55krBiVqUo95pAwIkEQ1zM2llCWbujZ+lll0aQp
fvD+IQKBgQCub7k79dpeFFypT4Zwnh0IRbj+nO/9YEH9lJYCSmRAaC3OVmQw52OO
dKq8tCfAzDpaOU0Upvh4tYfCBF2IV9JsXeS8TOMILwTULfre200W4dluKDWUzVnX
oKbh7m6fh1SRa7xtYiVAgadrFvXp6DgVgu1vmHTYxmGLx9p9vRfmLQ==
-----END RSA PRIVATE KEY-----",
           certificate:                         "-----BEGIN CERTIFICATE-----
MIIERTCCAy2gAwIBAgIJAMxQZsoCRpfQMA0GCSqGSIb3DQEBBQUAMHQxCzAJBgNV
BAYTAlVZMRMwEQYDVQQIEwpNb250ZXZpZGVvMRMwEQYDVQQHEwpNb250ZXZpZGVv
MQwwCgYDVQQKEwNJTU0xDDAKBgNVBAsTA0lOVjEfMB0GA1UEAxMWdGVzdGRydXBh
bDIuaW1tLmd1Yi51eTAeFw0xNzAxMjMxNzQ0MTZaFw0yNzAxMjMxNzQ0MTZaMHQx
CzAJBgNVBAYTAlVZMRMwEQYDVQQIEwpNb250ZXZpZGVvMRMwEQYDVQQHEwpNb250
ZXZpZGVvMQwwCgYDVQQKEwNJTU0xDDAKBgNVBAsTA0lOVjEfMB0GA1UEAxMWdGVz
dGRydXBhbDIuaW1tLmd1Yi51eTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAPfJ1W9rVCWlvBYF9+qUwdDw94qb36B4akmiNvkcrYHDs3bsZgVGCM3qMIuU
ZBv6Me6UVNVsGOBx7yfaQszZnEdpBAgslfk2CzoI6qdc2Md4oEOLI/TbGg8PrLlB
9ocI0xZ4QAXQoB1m9krAsEDDAOad5qu5dj1fY3ApzpAlJXrQeCY8bo0kS8V0JSas
x5i2MFeVSUFIiRiAC41PE2YDF3DNbF2/LRxixv+EQiC1aYVOuG+4QvXxfxbx6L2Z
opJfNGwZ/02w/trS2li9HkxtRyZJDvfd8T8B0HzYMkjRp383VCs5eHuGaG65Ybq4
X+m/Ln99Wuk9tgCCDePVjzifmXkCAwEAAaOB2TCB1jAdBgNVHQ4EFgQUbGr/4eEg
4xeywYUfmiDjUrIdA20wgaYGA1UdIwSBnjCBm4AUbGr/4eEg4xeywYUfmiDjUrId
A22heKR2MHQxCzAJBgNVBAYTAlVZMRMwEQYDVQQIEwpNb250ZXZpZGVvMRMwEQYD
VQQHEwpNb250ZXZpZGVvMQwwCgYDVQQKEwNJTU0xDDAKBgNVBAsTA0lOVjEfMB0G
A1UEAxMWdGVzdGRydXBhbDIuaW1tLmd1Yi51eYIJAMxQZsoCRpfQMAwGA1UdEwQF
MAMBAf8wDQYJKoZIhvcNAQEFBQADggEBAMKpakIduNJdoBp4eTciVue4b9RSd/GL
I5MPVOSc2zQUjPFYtwp33syPsYo3/JLUBVNnO/8k0iQuN+iVrRTGqqrg6j4gkOZ1
XZQt8LCOAEqOPNt0fIo819wvrfx/S9+ZcGXU81zfS+UdlZ9QcRsQKtCO8ZniaQL6
bo4KFiZ4fv/1xOWKLl3Omxh5j5R69xRWUKbJqOUS5UvzMgybbs01CXTBRvryYXta
WSzm8vqvqWh020fQfKHg8sba/wuKJS3LT9lL8xUboin0SnTl/UR7BYs1/IuzGKSJ
Hiw+Y0UUMIr1pAlYdnrlv2fL7XW2XBKOIca1LVxQRhrJifDj5+dQqV8=
-----END CERTIFICATE-----",
           security:                            {
                                                  :authn_requests_signed      => true,
                                                  :logout_requests_signed     => false,
                                                  :logout_responses_signed    => false,
                                                  :want_assertions_signed     => false,
                                                  :want_assertions_encrypted  => false,
                                                  :want_name_id               => false,
                                                  :metadata_signed            => false,
                                                  :embed_sign                 => false,
                                                  :digest_method              => XMLSecurity::Document::SHA256,
                                                  :signature_method           => XMLSecurity::Document::RSA_SHA256
                                                }
end
