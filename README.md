This repository provide the irule needed to recalculate radius accounting request Authenticator value.
The recalculation needed when radius accounting modification is performed. This is due to according to RFC 2866 as quoted below

      "The Request Authenticator field in Accounting-Request packets contains a one-
      way MD5 hash calculated over a stream of octets consisting of the
      Code + Identifier + Length + 16 zero octets + request attributes +
      shared secret (where + indicates concatenation).  The 16 octet MD5
      hash value is stored in the Authenticator field of the
      Accounting-Request packet."

The logic used to recalculate the Authenticator value are
- concatenate Radius Code+ID+Length+16zero octets+avps+secret in binary format
- the avps is all the payload data after Authenticator
- perform md5 hash to the concatenated above
- replace the old Authenticator with the new hash
