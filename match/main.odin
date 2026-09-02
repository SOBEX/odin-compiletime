package odin_compiletime_match

/*
string matching similar to `core:text/match` but with compiletime known patterns (and no utf-8 support)

.  wildcard
%a any letter               "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzªµºÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ"
%c any control characters   "\x00\x01\x02\x03\x04\x05\x06\a\b\t\n\v\f\r\x0e\x0f\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\e\x1c\x1d\x1e\x1f\u007f\u0080\u0081\u0082\u0083\u0084\u0085\u0086\u0087\u0088\u0089\u008a\u008b\u008c\u008d\u008e\u008f\u0090\u0091\u0092\u0093\u0094\u0095\u0096\u0097\u0098\u0099\u009a\u009b\u009c\u009d\u009e\u009f"
%d any decimal digit        "0123456789²³¹"
%g any graph                "0123456789ABCDEFabcdef²³¹"
%l any lowercase letter     "abcdefghijklmnopqrstuvwxyzªµºßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ"
%p any punctuation          "!\"#%&'()*,-./:;?@[\\]_{}¡§«¶·»¿"
%s any whitespace character "\t\n\v\f\r \u0085\u00a0"
%u any uppercase letter     "ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞ"
%w any word character       "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzª²³µ¹ºÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ"
%x any hexadecimal digit    "0123456789ABCDEFabcdef²³¹"
*  lazy 0+ repeats
?  lazy 0 or 1
^  begin
$  end
%. literal '.'
%* literal '*'
%? literal '?'
%^ literal '^'
%$ literal '$'
%% literal '%'
*/

Char_Property::enum u8{
   c,d,l,p,s,u,w,x
}
Char_Properties::bit_set[Char_Property;u8]

@rodata char_properties:=[256]Char_Properties{
   0x00={.c},//'\x00'
   0x01={.c},//'\x01'
   0x02={.c},//'\x02'
   0x03={.c},//'\x03'
   0x04={.c},//'\x04'
   0x05={.c},//'\x05'
   0x06={.c},//'\x06'
   0x07={.c},//'\a'
   0x08={.c},//'\b'
   0x09={.c, .s},//'\t'
   0x0A={.c, .s},//'\n'
   0x0B={.c, .s},//'\v'
   0x0C={.c, .s},//'\f'
   0x0D={.c, .s},//'\r'
   0x0E={.c},//'\x0e'
   0x0F={.c},//'\x0f'
   0x10={.c},//'\x10'
   0x11={.c},//'\x11'
   0x12={.c},//'\x12'
   0x13={.c},//'\x13'
   0x14={.c},//'\x14'
   0x15={.c},//'\x15'
   0x16={.c},//'\x16'
   0x17={.c},//'\x17'
   0x18={.c},//'\x18'
   0x19={.c},//'\x19'
   0x1A={.c},//'\x1a'
   0x1B={.c},//'\e'
   0x1C={.c},//'\x1c'
   0x1D={.c},//'\x1d'
   0x1E={.c},//'\x1e'
   0x1F={.c},//'\x1f'
   0x20={.s},//' '
   0x21={.p},//'!'
   0x22={.p},//'"'
   0x23={.p},//'#'
   0x24={},//'$'
   0x25={.p},//'%'
   0x26={.p},//'&'
   0x27={.p},//'\''
   0x28={.p},//'('
   0x29={.p},//')'
   0x2A={.p},//'*'
   0x2B={},//'+'
   0x2C={.p},//','
   0x2D={.p},//'-'
   0x2E={.p},//'.'
   0x2F={.p},//'/'
   0x30={.d, .w, .x},//'0'
   0x31={.d, .w, .x},//'1'
   0x32={.d, .w, .x},//'2'
   0x33={.d, .w, .x},//'3'
   0x34={.d, .w, .x},//'4'
   0x35={.d, .w, .x},//'5'
   0x36={.d, .w, .x},//'6'
   0x37={.d, .w, .x},//'7'
   0x38={.d, .w, .x},//'8'
   0x39={.d, .w, .x},//'9'
   0x3A={.p},//':'
   0x3B={.p},//';'
   0x3C={},//'<'
   0x3D={},//'='
   0x3E={},//'>'
   0x3F={.p},//'?'
   0x40={.p},//'@'
   0x41={.u, .w, .x},//'A'
   0x42={.u, .w, .x},//'B'
   0x43={.u, .w, .x},//'C'
   0x44={.u, .w, .x},//'D'
   0x45={.u, .w, .x},//'E'
   0x46={.u, .w, .x},//'F'
   0x47={.u, .w},//'G'
   0x48={.u, .w},//'H'
   0x49={.u, .w},//'I'
   0x4A={.u, .w},//'J'
   0x4B={.u, .w},//'K'
   0x4C={.u, .w},//'L'
   0x4D={.u, .w},//'M'
   0x4E={.u, .w},//'N'
   0x4F={.u, .w},//'O'
   0x50={.u, .w},//'P'
   0x51={.u, .w},//'Q'
   0x52={.u, .w},//'R'
   0x53={.u, .w},//'S'
   0x54={.u, .w},//'T'
   0x55={.u, .w},//'U'
   0x56={.u, .w},//'V'
   0x57={.u, .w},//'W'
   0x58={.u, .w},//'X'
   0x59={.u, .w},//'Y'
   0x5A={.u, .w},//'Z'
   0x5B={.p},//'['
   0x5C={.p},//'\\'
   0x5D={.p},//']'
   0x5E={},//'^'
   0x5F={.p},//'_'
   0x60={},//'`'
   0x61={.l, .w, .x},//'a'
   0x62={.l, .w, .x},//'b'
   0x63={.l, .w, .x},//'c'
   0x64={.l, .w, .x},//'d'
   0x65={.l, .w, .x},//'e'
   0x66={.l, .w, .x},//'f'
   0x67={.l, .w},//'g'
   0x68={.l, .w},//'h'
   0x69={.l, .w},//'i'
   0x6A={.l, .w},//'j'
   0x6B={.l, .w},//'k'
   0x6C={.l, .w},//'l'
   0x6D={.l, .w},//'m'
   0x6E={.l, .w},//'n'
   0x6F={.l, .w},//'o'
   0x70={.l, .w},//'p'
   0x71={.l, .w},//'q'
   0x72={.l, .w},//'r'
   0x73={.l, .w},//'s'
   0x74={.l, .w},//'t'
   0x75={.l, .w},//'u'
   0x76={.l, .w},//'v'
   0x77={.l, .w},//'w'
   0x78={.l, .w},//'x'
   0x79={.l, .w},//'y'
   0x7A={.l, .w},//'z'
   0x7B={.p},//'{'
   0x7C={},//'|'
   0x7D={.p},//'}'
   0x7E={},//'~'
   0x7F={.c},//'\u007f'
   0x80={.c},//'\u0080'
   0x81={.c},//'\u0081'
   0x82={.c},//'\u0082'
   0x83={.c},//'\u0083'
   0x84={.c},//'\u0084'
   0x85={.c, .s},//'\u0085'
   0x86={.c},//'\u0086'
   0x87={.c},//'\u0087'
   0x88={.c},//'\u0088'
   0x89={.c},//'\u0089'
   0x8A={.c},//'\u008a'
   0x8B={.c},//'\u008b'
   0x8C={.c},//'\u008c'
   0x8D={.c},//'\u008d'
   0x8E={.c},//'\u008e'
   0x8F={.c},//'\u008f'
   0x90={.c},//'\u0090'
   0x91={.c},//'\u0091'
   0x92={.c},//'\u0092'
   0x93={.c},//'\u0093'
   0x94={.c},//'\u0094'
   0x95={.c},//'\u0095'
   0x96={.c},//'\u0096'
   0x97={.c},//'\u0097'
   0x98={.c},//'\u0098'
   0x99={.c},//'\u0099'
   0x9A={.c},//'\u009a'
   0x9B={.c},//'\u009b'
   0x9C={.c},//'\u009c'
   0x9D={.c},//'\u009d'
   0x9E={.c},//'\u009e'
   0x9F={.c},//'\u009f'
   0xA0={.s},//'\u00a0'
   0xA1={.p},//'¡'
   0xA2={},//'¢'
   0xA3={},//'£'
   0xA4={},//'¤'
   0xA5={},//'¥'
   0xA6={},//'¦'
   0xA7={.p},//'§'
   0xA8={},//'¨'
   0xA9={},//'©'
   0xAA={.l, .w},//'ª'
   0xAB={.p},//'«'
   0xAC={},//'¬'
   0xAD={},//'\u00ad'
   0xAE={},//'®'
   0xAF={},//'¯'
   0xB0={},//'°'
   0xB1={},//'±'
   0xB2={.d, .w, .x},//'²'
   0xB3={.d, .w, .x},//'³'
   0xB4={},//'´'
   0xB5={.l, .w},//'µ'
   0xB6={.p},//'¶'
   0xB7={.p},//'·'
   0xB8={},//'¸'
   0xB9={.d, .w, .x},//'¹'
   0xBA={.l, .w},//'º'
   0xBB={.p},//'»'
   0xBC={},//'¼'
   0xBD={},//'½'
   0xBE={},//'¾'
   0xBF={.p},//'¿'
   0xC0={.u, .w},//'À'
   0xC1={.u, .w},//'Á'
   0xC2={.u, .w},//'Â'
   0xC3={.u, .w},//'Ã'
   0xC4={.u, .w},//'Ä'
   0xC5={.u, .w},//'Å'
   0xC6={.u, .w},//'Æ'
   0xC7={.u, .w},//'Ç'
   0xC8={.u, .w},//'È'
   0xC9={.u, .w},//'É'
   0xCA={.u, .w},//'Ê'
   0xCB={.u, .w},//'Ë'
   0xCC={.u, .w},//'Ì'
   0xCD={.u, .w},//'Í'
   0xCE={.u, .w},//'Î'
   0xCF={.u, .w},//'Ï'
   0xD0={.u, .w},//'Ð'
   0xD1={.u, .w},//'Ñ'
   0xD2={.u, .w},//'Ò'
   0xD3={.u, .w},//'Ó'
   0xD4={.u, .w},//'Ô'
   0xD5={.u, .w},//'Õ'
   0xD6={.u, .w},//'Ö'
   0xD7={},//'×'
   0xD8={.u, .w},//'Ø'
   0xD9={.u, .w},//'Ù'
   0xDA={.u, .w},//'Ú'
   0xDB={.u, .w},//'Û'
   0xDC={.u, .w},//'Ü'
   0xDD={.u, .w},//'Ý'
   0xDE={.u, .w},//'Þ'
   0xDF={.l, .w},//'ß'
   0xE0={.l, .w},//'à'
   0xE1={.l, .w},//'á'
   0xE2={.l, .w},//'â'
   0xE3={.l, .w},//'ã'
   0xE4={.l, .w},//'ä'
   0xE5={.l, .w},//'å'
   0xE6={.l, .w},//'æ'
   0xE7={.l, .w},//'ç'
   0xE8={.l, .w},//'è'
   0xE9={.l, .w},//'é'
   0xEA={.l, .w},//'ê'
   0xEB={.l, .w},//'ë'
   0xEC={.l, .w},//'ì'
   0xED={.l, .w},//'í'
   0xEE={.l, .w},//'î'
   0xEF={.l, .w},//'ï'
   0xF0={.l, .w},//'ð'
   0xF1={.l, .w},//'ñ'
   0xF2={.l, .w},//'ò'
   0xF3={.l, .w},//'ó'
   0xF4={.l, .w},//'ô'
   0xF5={.l, .w},//'õ'
   0xF6={.l, .w},//'ö'
   0xF7={},//'÷'
   0xF8={.l, .w},//'ø'
   0xF9={.l, .w},//'ù'
   0xFA={.l, .w},//'ú'
   0xFB={.l, .w},//'û'
   0xFC={.l, .w},//'ü'
   0xFD={.l, .w},//'ý'
   0xFE={.l, .w},//'þ'
   0xFF={.l, .w},//'ÿ'
}

is_a::#force_inline proc(c:u8)->bool #no_bounds_check{return char_properties[c]&{.l,.u}!={}}
is_c::#force_inline proc(c:u8)->bool #no_bounds_check{return char_properties[c]&{.c}!={}}
is_d::#force_inline proc(c:u8)->bool #no_bounds_check{return char_properties[c]&{.d}!={}}
is_g::#force_inline proc(c:u8)->bool #no_bounds_check{return char_properties[c]&{.x}!={}}
is_l::#force_inline proc(c:u8)->bool #no_bounds_check{return char_properties[c]&{.l}!={}}
is_p::#force_inline proc(c:u8)->bool #no_bounds_check{return char_properties[c]&{.p}!={}}
is_s::#force_inline proc(c:u8)->bool #no_bounds_check{return char_properties[c]&{.s}!={}}
is_u::#force_inline proc(c:u8)->bool #no_bounds_check{return char_properties[c]&{.u}!={}}
is_w::#force_inline proc(c:u8)->bool #no_bounds_check{return char_properties[c]&{.w}!={}}
is_x::#force_inline proc(c:u8)->bool #no_bounds_check{return char_properties[c]&{.x}!={}}

NOT_FOUND::-1

match::proc(str:string,$pattern:string)->(capture:string,begin,end:int,was_found:bool){
   _match::proc(str:string,pos:int,$i:int)->int{
      is_finished::i==len(pattern)
      when is_finished{
         return pos
      }else{
         is_asterisk::pattern[i]=='*'
         is_question_mark::pattern[i]=='?'
         is_caret::pattern[i]=='^'
         is_dollar::pattern[i]=='$'
         starts_with_percent::pattern[i]=='%'
         when is_asterisk{
            #panic("Invalid unescaped asterisk")
         }else when is_question_mark{
            #panic("Invalid unescaped question mark")
         }else when is_caret{
            #panic("Invalid unescaped caret")
         }else when is_dollar{
            when i+1==len(pattern){
               if pos==len(str){
                  return pos
               }else{
                  return NOT_FOUND
               }
            }else{
               #panic("Unescaped end marker in the middle of pattern")
            }
         }else when starts_with_percent{
            is_finished_after_percent::i+1==len(pattern)
            when is_finished_after_percent{
               #panic("Unfinished escape at end of pattern")
            }else{
               group::pattern[i+1]
               when group=='a'{
                  is_matching:=len(str)>pos&&is_a(str[pos])
               }else when group=='c'{
                  is_matching:=len(str)>pos&&is_c(str[pos])
               }else when group=='d'{
                  is_matching:=len(str)>pos&&is_d(str[pos])
               }else when group=='g'{
                  is_matching:=len(str)>pos&&is_g(str[pos])
               }else when group=='l'{
                  is_matching:=len(str)>pos&&is_l(str[pos])
               }else when group=='p'{
                  is_matching:=len(str)>pos&&is_p(str[pos])
               }else when group=='s'{
                  is_matching:=len(str)>pos&&is_s(str[pos])
               }else when group=='u'{
                  is_matching:=len(str)>pos&&is_u(str[pos])
               }else when group=='w'{
                  is_matching:=len(str)>pos&&is_w(str[pos])
               }else when group=='x'{
                  is_matching:=len(str)>pos&&is_x(str[pos])
               }else when group=='.'{
                  is_matching:=len(str)>pos&&str[pos]=='.'
               }else when group=='*'{
                  is_matching:=len(str)>pos&&str[pos]=='*'
               }else when group=='?'{
                  is_matching:=len(str)>pos&&str[pos]=='?'
               }else when group=='^'{
                  is_matching:=len(str)>pos&&str[pos]=='^'
               }else when group=='$'{
                  is_matching:=len(str)>pos&&str[pos]=='$'
               }else when group=='%'{
                  is_matching:=len(str)>pos&&str[pos]=='%'
               }else{
                  #panic("Invalid escaped character "+pattern[i:i+2])
               }
               is_next_star::pattern[i+2]=='*' when i+2<len(pattern) else false
               is_next_optional::pattern[i+2]=='?' when i+2<len(pattern) else false
               when is_next_star{
                  end:=#force_inline _match(str,pos,i+3)
                  if end!=NOT_FOUND{
                     return end
                  }
                  if is_matching{
                     return #must_tail _match(str,pos+1,i)
                  }else{
                     return NOT_FOUND
                  }
               }else when is_next_optional{
                  end:=#force_inline _match(str,pos,i+3)
                  if end!=NOT_FOUND{
                     return end
                  }
                  if is_matching{
                     return #force_inline _match(str,pos+1,i+3)
                  }else{
                     return NOT_FOUND
                  }
               }else{
                  if is_matching{
                     return #force_inline _match(str,pos+1,i+2)
                  }else{
                     return NOT_FOUND
                  }
               }
            }
         }else{
            is_dot::pattern[i]=='.'
            when is_dot{
               is_matching:=len(str)>pos
            }else{
               is_matching:=len(str)>pos&&str[pos]==pattern[i]
            }
            is_next_star::pattern[i+1]=='*' when i+1<len(pattern) else false
            is_next_optional::pattern[i+1]=='?' when i+1<len(pattern) else false
            when is_next_star{
               end:=#force_inline _match(str,pos,i+2)
               if end!=NOT_FOUND{
                  return end
               }
               if is_matching{
                  return #must_tail _match(str,pos+1,i)
               }else{
                  return NOT_FOUND
               }
            }else when is_next_optional{
               end:=#force_inline _match(str,pos,i+2)
               if end!=NOT_FOUND{
                  return end
               }
               if is_matching{
                  return #force_inline _match(str,pos+1,i+2)
               }else{
                  return NOT_FOUND
               }
            }else{
               if is_matching{
                  return #force_inline _match(str,pos+1,i+1)
               }else{
                  return NOT_FOUND
               }
            }
         }
      }
   }
   is_empty_pattern::len(pattern)==0
   when is_empty_pattern{
      return str[:0],0,0,true
   }else{
      starts_with_caret::pattern[0]=='^'
      when starts_with_caret{
         maybe_end:=#force_inline _match(str,0,1)
         if maybe_end!=NOT_FOUND{
            return str[:maybe_end],0,maybe_end,true
         }
         return "",NOT_FOUND,NOT_FOUND,false
      }else{
         for maybe_begin in 0..=len(str){
            maybe_end:=#force_inline _match(str,maybe_begin,0)
            if maybe_end!=NOT_FOUND{
               return str[maybe_begin:maybe_end],maybe_begin,maybe_end,true
            }
         }
         return "",NOT_FOUND,NOT_FOUND,false
      }
   }
}
