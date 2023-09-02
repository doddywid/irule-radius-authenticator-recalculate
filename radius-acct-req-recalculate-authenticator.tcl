############################################################################################################
# This block should be put to the end of existing radius irules, for calculating new request authenticator #
############################################################################################################
    
    #set required var to calculate new request authenticator
    set secret "mynewsecret"
    set payload [UDP::payload]
    
    #calculate new request authenticator and update UDP payload
    set secret [binary format a* $secret]
    binary scan $secret H* secret
    binary scan $payload H2H2H4x16H* code id len avps
    set req_auth [binary format H* ${code}${id}${len}00000000000000000000000000000000${avps}${secret}]
    set req_auth [md5 $req_auth]
    binary scan $req_auth H* req_auth
    binary scan $payload H8x16H* leftpayload rightpayload
    set newpayload [binary format H* $leftpayload$req_auth$rightpayload]
    UDP::payload replace 0 0 $newpayload
    UDP::payload replace [string length $newpayload] [expr [UDP::payload length] - [string length $newpayload]] ""
