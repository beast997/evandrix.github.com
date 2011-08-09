module Rex
module Post
module Meterpreter
module Extensions
module Sniffer

TLV_TYPE_EXTENSION_SNIFFER     = 0
TLV_TYPE_SNIFFER_INTERFACES    = TLV_META_TYPE_GROUP | (TLV_TYPE_EXTENSION_SNIFFER + TLV_EXTENSIONS + 1)
TLV_TYPE_SNIFFER_INTERFACE_ID  = TLV_META_TYPE_UINT  | (TLV_TYPE_EXTENSION_SNIFFER + TLV_EXTENSIONS + 2)
TLV_TYPE_SNIFFER_INTERFACE_HANDLE  = TLV_META_TYPE_UINT  | (TLV_TYPE_EXTENSION_SNIFFER + TLV_EXTENSIONS + 3)
TLV_TYPE_SNIFFER_PACKET_COUNT  = TLV_META_TYPE_UINT  | (TLV_TYPE_EXTENSION_SNIFFER + TLV_EXTENSIONS + 4)
TLV_TYPE_SNIFFER_BYTE_COUNT    = TLV_META_TYPE_UINT  | (TLV_TYPE_EXTENSION_SNIFFER + TLV_EXTENSIONS + 5)

TLV_TYPE_SNIFFER_EXCLUDE_PORTS = TLV_META_TYPE_GROUP | (TLV_TYPE_EXTENSION_SNIFFER + TLV_EXTENSIONS + 6)
TLV_TYPE_SNIFFER_INCLUDE_PORTS = TLV_META_TYPE_GROUP | (TLV_TYPE_EXTENSION_SNIFFER + TLV_EXTENSIONS + 7)

TLV_TYPE_SNIFFER_PACKETS       = TLV_META_TYPE_GROUP  | (TLV_TYPE_EXTENSION_SNIFFER + TLV_EXTENSIONS + 8)
TLV_TYPE_SNIFFER_PACKET        = TLV_META_TYPE_RAW    | (TLV_TYPE_EXTENSION_SNIFFER + TLV_EXTENSIONS + 9)

end
end
end
end
end