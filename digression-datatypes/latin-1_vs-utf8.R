name_utf8_bytes    <- paste0( "\x52" , "\x65" , "\x6e" , "\xc3" , "\xa9" );
name_latin_1_bytes <- paste0( "\x52" , "\x65" , "\x6e" , "\xe9" );

name_utf8_bytes;
name_latin_1_bytes;

Encoding(name_utf8_bytes   );
Encoding(name_latin_1_bytes);

Encoding(name_utf8_bytes   ) <- 'UTF-8';
# Encoding(name_latin_1_bytes) <- 'UTF-8';
name_utf8_bytes;

name <- "René"
Encoding(name);
charToRaw(name);

name_utf8 <- enc2utf8(name);
name_utf8;
Encoding(name_utf8);
charToRaw(name_utf8);
