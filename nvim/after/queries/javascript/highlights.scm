;; extends
(jsx_attribute (property_identifier) @att_name (#eq? @att_name "className")
  (string (string_fragment) @att_val (#set! @att_val conceal ".")
  )
)
