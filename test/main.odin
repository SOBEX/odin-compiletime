package odin_compiletime_match_test

import my_match ".."
import core_match "core:text/match"

import "core:fmt"
import "core:log"
import "core:strings"
import "core:testing"
import "core:time"

main::proc(){
   print_chars()

   context.logger=log.create_console_logger()
   defer log.destroy_console_logger(context.logger)

   does_empty_pattern_keep_data_pointer(nil)
   test(nil)
   benchmark(nil)
}

@test does_empty_pattern_keep_data_pointer::proc(t:^testing.T){
   str:="yea"
   capture,begin,end,was_found:=my_match.match(str,"")
   testing.expect(t,was_found)
   testing.expect_value(t,raw_data(capture),raw_data(str))
}

@test test::proc(t:^testing.T){
   expect::proc(t:^testing.T,str:string,$pattern:string,expected_capture:string,expected_begin,expected_end:int,expected_was_found:bool){
      capture,begin,end,was_found:=my_match.match(str,pattern)
      if capture!=expected_capture||begin!=expected_begin||end!=expected_end||was_found!=expected_was_found{
         fmt.printfln("Failed matching %q on %q, expected (%q, %d, %d, %v), got (%q, %d, %d, %v)",pattern,str,expected_capture,expected_begin,expected_end,expected_was_found,capture,begin,end,was_found)
      }
      testing.expect_value(t,compress_values(capture,begin,end,was_found),compress_values(expected_capture,expected_begin,expected_end,expected_was_found))
   }

   NOT_FOUND::my_match.NOT_FOUND

   expect(t,"abc","abc","abc",0,3,true)
   expect(t,"abcd","abc","abc",0,3,true)
   expect(t,"abc","abcd","",NOT_FOUND,NOT_FOUND,false)
   expect(t,"","","",0,0,true)
   expect(t,"","a","",NOT_FOUND,NOT_FOUND,false)

   expect(t,"","a*","",0,0,true)
   expect(t,"a","a*","",0,0,true)
   expect(t,"aaaa","a*","",0,0,true)
   expect(t,"ac","ab*c","ac",0,2,true)
   expect(t,"abbbc","ab*c","abbbc",0,5,true)
   expect(t,"abx","ab*c","",NOT_FOUND,NOT_FOUND,false)

   expect(t,"abc","a.c","abc",0,3,true)
   expect(t,"axc","a.c","axc",0,3,true)
   expect(t,"abbc","a.c","",NOT_FOUND,NOT_FOUND,false)
   expect(t,"abbbc","a.*c","abbbc",0,5,true)
   expect(t,"anything",".*","",0,0,true)

   expect(t,"color","colou?r","color",0,5,true)
   expect(t,"colour","colou?r","colour",0,6,true)
   expect(t,"colouur","colou?r","",NOT_FOUND,NOT_FOUND,false)
   expect(t,"","a?","",0,0,true)

   // ============================================================================

   expect(t,"","","",0,0,true)

   expect(t,"odin","","",0,0,true)

   expect(t,"aaa","a*","",0,0,true)
   expect(t,"aaab","a*b","aaab",0,4,true)

   expect(t,"color","colou?r","color",0,5,true)
   expect(t,"colour","colou?r","colour",0,6,true)

   expect(t,"backtracking","t.a","tra",4,7,true)
   expect(t,"abcdef","b.*e","bcde",1,5,true)

   // ============================================================================

   // 1. Your original test case (Lazy backtracking on optional & star)
   expect(t, "aaabbbccc", "a?b*cc*", "abbbc", 2, 7, true)

   // 2. Deep star backtracking (forces engine to unwind multiple nested steps)
   expect(t, "mississippi", "i*s*is*i", "issi", 1, 5, true)

   // 3. Overlapping star patterns
   expect(t, "bba", "b*b*a", "bba", 0, 3, true)

   // 4. Wildcard + Star backtracking
   expect(t, "popypye", "p.p*y", "popy", 0, 4, true)

   // 5. Lazy dot-star (should match up to the FIRST slash, not the last)
   expect(t, "path/to/file.txt", ".*/", "path/", 0, 5, true)

   // 6. Multiple adjacent optionals matching varying lengths
   expect(t, "colourss", "colou?r?s", "colours", 0, 7, true)
   expect(t, "colors", "colou?r?s", "colors", 0, 6, true)

   // 7. Complete lazy matching to empty string (all quantifiers skipped)
   expect(t, "abc", "a*b*c*", "", 0, 0, true)

   // 8. Total match failure after deep backtracking exhaustion
   expect(t, "abc", "a*b*c*d", "", NOT_FOUND, NOT_FOUND, false)

   // ============================================================================

   // 1. Double-star backtrack recursion (the engine must unwind multiple '*' states)
   expect(t, "mississip", "i*s*i*s*p", "issip", 4, 9, true) // should fail gracefully
   expect(t, "mississippi", "m*i*s*s*i*s*s*i*p*p*i*", "", 0, 0, true) // lazy matches "" at index 0

   // 2. The "Almost-Match" at EOF (ensuring correct out-of-bounds safety)
   expect(t, "abc", "abcd*", "abc", 0, 3, true) // d* can match 0 chars at EOF
   expect(t, "abc", "a*b*c*d", "", NOT_FOUND, NOT_FOUND, false)    // fails correctly when d is missing at EOF

   // 3. Nested Wildcard/Star traps
   expect(t, "abbbcbc", "a.*b*c", "abbbc", 0, 5, true)

   // 4. Overlapping optional components
   expect(t, "ab", "a?b?b", "ab", 0, 2, true)
   expect(t, "b", "a?b?b", "b", 0, 1, true)

   // 5. Interleaved dot and optionals
   // "a.?.?b" on "axb" -> should match "axb"
   expect(t, "axb", "a.?.?b", "axb", 0, 3, true)
   expect(t, "ab", "a.?.?b", "ab", 0, 2, true)

   // 6. Long scanning failures (checks search loop and state clearing)
   expect(t, "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzza", "z*b", "", NOT_FOUND, NOT_FOUND, false)

   // ============================================================================
   // SECTION 1: Basic Feature Showcase
   // ============================================================================

   // Literals & Wildcard
   expect(t, "abc", "abc", "abc", 0, 3, true)
   expect(t, "axc", "a.c", "axc", 0, 3, true)

   // Quantifiers (Lazy)
   expect(t, "aaa", "a*", "", 0, 0, true) // Lazy matching 0 chars
   expect(t, "aaab", "a*b", "aaab", 0, 4, true) // Backtracks to consume 'a's
   expect(t, "ab", "a?b", "ab", 0, 2, true)
   expect(t, "b", "a?b", "b", 0, 1, true)

   // Character Classes
   expect(t, "123", "%d*", "", 0, 0, true)
   expect(t, "123a", "%d*a", "123a", 0, 4, true)
   expect(t, "hello", "%l*", "", 0, 0, true)
   expect(t, "hello!", "%l*%p", "hello!", 0, 6, true)
   expect(t, "A1 ", "%u%d%s", "A1 ", 0, 3, true)

   // Escapes
   expect(t, "a*b", "a%*b", "a*b", 0, 3, true)
   expect(t, "a?b", "a%?b", "a?b", 0, 3, true)
   expect(t, "a%%b", "a%%%%b", "a%%b", 0, 4, true) // Matching escaped '%'

   // Anchors
   expect(t, "abc", "^abc", "abc", 0, 3, true)
   expect(t, "abc", "abc$", "abc", 0, 3, true)

   // ============================================================================
   // SECTION 2: Complex Edge Cases
   // ============================================================================

   // 1. Empty strings and empty patterns
   expect(t, "", "", "", 0, 0, true)
   expect(t, "abc", "", "", 0, 0, true)
   expect(t, "", "a*", "", 0, 0, true)
   expect(t, "", "a?", "", 0, 0, true)
   expect(t, "", "a", "", NOT_FOUND, NOT_FOUND, false)

   // 2. Failure to match after exhausting deep backtracking
   expect(t, "aaaaab", "a*c", "", NOT_FOUND, NOT_FOUND, false)
   expect(t, "axaxaxb", "a.%*b", "", NOT_FOUND, NOT_FOUND, false)

   // 3. Anchor restriction failures
   expect(t, "babc", "^abc", "", NOT_FOUND, NOT_FOUND, false)
   expect(t, "abcd", "abc$", "", NOT_FOUND, NOT_FOUND, false)

   // 4. Overlapping quantifiers & greedy traps (testing correctness of non-greedy)
   expect(t, "abbbc", "ab*b*c", "abbbc", 0, 5, true)
   expect(t, "abbbc", "a%w*b%w*c", "abbbc", 0, 5, true)

   /*
      // 5. Extended character classes from custom table
      expect(t, "µ", "%l", "µ", 0, 2, true) // Latin-1 Lowercase
      expect(t, "À", "%u", "À", 0, 2, true) // Latin-1 Uppercase
      expect(t, "²", "%d", "²", 0, 2, true) // Latin-1 Digit
      expect(t, "¡", "%p", "¡", 0, 2, true) // Latin-1 Punctuation
   */

   // 6. Anchored single-character boundaries
   expect(t, "a", "^a$", "a", 0, 1, true)
   expect(t, "ab", "^a$", "", NOT_FOUND, NOT_FOUND, false)

   // 7. Missing trailing optional on EOF boundary
   expect(t, "abc", "abc%w?", "abc", 0, 3, true)


   // ============================================================================
   // SECTION 3: Pathological and Long Inputs
   // ============================================================================

   // 1. Catastrophic backtracking protection/correctness (100+ chars)
   // Lazy engine should quickly determine failure when 'c' is missing
   expect(
      t,
      "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab",
      "a*a*a*a*c",
      "",
      NOT_FOUND,
      NOT_FOUND,
      false,
   )

   // 2. Complex interleaved whitespace and punctuation classes
   expect(
      t,
      " @\t!# \n%[abc]  ",
      "%s%s*%p%p*%s%s*%p%p*%s%s*",
      " @\t!# ",
      0,
      6,
      true,
   )

   // 3. Dense escape-heavy literal matching
   expect(t, "%%**??^^$$", "%%%%%*%*%?%?%^%^%$%$", "%%**??^^$$", 0, 10, true)

   // 4. Overlapping quantifiers forced to the boundary of EOF
   expect(t, "xxxxxxy", "x?x?x?x?x?x?y", "xxxxxxy", 0, 7, true)
   expect(t, "xxxxxy", "x?x?x?x?x?x?y", "xxxxxy", 0, 6, true)

   // 5. Anchor verification with mid-string matches
   // Ensure '$' doesn't falsely match on embedded lookalikes
   expect(t, "abc$def", "abc$", "", NOT_FOUND, NOT_FOUND, false)
   expect(t, "abc$def", "abc%%$", "", NOT_FOUND, NOT_FOUND, false) // matches literal %$
   expect(t, "abc$", "abc%$", "abc$", 0, 4, true)

   // Ensure '^' doesn't match after a newline (it is a strict string start)
   expect(t, "abc\ndef", "^def", "", NOT_FOUND, NOT_FOUND, false)

   // 6. Deep lazy recovery over wildcards
   expect(
      t,
      "the quick brown fox jumps over the lazy dog",
      "the.*lazy.*dog",
      "the quick brown fox jumps over the lazy dog",
      0,
      43,
      true,
   )

   // 7. Graph class (%g) and Word class (%w) boundary checks
   expect(t, "abc123XYZ", "%g*", "", 0, 0, true)
   expect(t, "abc123XYZ!", "%g*!", "!", 9, 10, true)
   expect(t, "abc123XYZ!", "%w*!", "abc123XYZ!", 0, 10, true)
}

@test benchmark::proc(t:^testing.T){
   text:=#load("main.odin",string)

   my_lines:[dynamic;1024]string
   core_lines:[dynamic;1024]string
   strings_lines:[dynamic;1024]string

   my_text:=text
   my_start:=time.tick_now()
   for{
      line,_,end,was_found:=my_match.match(my_text,"^.*\n")
      if !was_found{
         break
      }
      append(&my_lines,line)
      my_text=my_text[end:]
   }
   my_end:=time.tick_now()

   core_matcher:=core_match.matcher_init(text,"^.-\n")
   core_start:=time.tick_now()
   for line,_ in core_match.matcher_match_iter(&core_matcher){
      append(&core_lines,line)
   }
   core_end:=time.tick_now()

   strings_text:=text
   strings_start:=time.tick_now()
   for line in strings.split_lines_iterator(&strings_text){
      append(&strings_lines,line)
   }
   strings_end:=time.tick_now()

   testing.expect_value(t,len(my_lines),len(core_lines))
   testing.expect_value(t,len(my_lines),len(strings_lines))

   for i in 0..<min(len(my_lines),len(core_lines)){
      testing.expect_value(t,my_lines[i],core_lines[i])
   }
   for i in 0..<min(len(my_lines),len(strings_lines)){
      testing.expect_value(t,strings.trim_right(my_lines[i],"\r\n"),strings_lines[i])
   }

   my_duration:=time.tick_diff(my_start,my_end)
   core_duration:=time.tick_diff(core_start,core_end)
   strings_duration:=time.tick_diff(strings_start,strings_end)

   fmt.println(my_duration)
   fmt.println(core_duration)
   fmt.println(strings_duration)
}

print_chars::proc(){
   Char_Property::enum{
      a,c,d,g,l,p,s,u,w,x
   }
   Char_Properties::bit_set[Char_Property]
   Original_Class::struct{
      name:string,
      short:rune,
      check:#type proc(rune)->bool,
      char_property:Char_Property
   }
   original_classes:=[?]Original_Class{
      {"alpha ",'a',core_match.is_alpha ,.a},
      {"cntrl ",'c',core_match.is_cntrl ,.c},
      {"digit ",'d',core_match.is_digit ,.d},
      {"graph ",'g',core_match.is_graph ,.g},
      {"lower ",'l',core_match.is_lower ,.l},
      {"punct ",'p',core_match.is_punct ,.p},
      {"space ",'s',core_match.is_space ,.s},
      {"upper ",'u',core_match.is_upper ,.u},
      {"alnum ",'w',core_match.is_alnum ,.w},
      {"xdigit",'x',core_match.is_xdigit,.x}
   }
   My_Class::struct{
      name:string,
      short:rune,
      check:#type proc(u8)->bool
   }
   my_classes:=[?]My_Class{
      {"alpha ",'a',my_match.is_a},
      {"cntrl ",'c',my_match.is_c},
      {"digit ",'d',my_match.is_d},
      {"graph ",'g',my_match.is_g},
      {"lower ",'l',my_match.is_l},
      {"punct ",'p',my_match.is_p},
      {"space ",'s',my_match.is_s},
      {"upper ",'u',my_match.is_u},
      {"alnum ",'w',my_match.is_w},
      {"xdigit",'x',my_match.is_x}
   }
   char_properties:[256]Char_Properties
   buffer:[1024]u8
   builder:=strings.builder_from_bytes(buffer[:])
   fmt.println("Original classes:")
   for class in original_classes{
      strings.builder_reset(&builder)
      for c in 0..=255{
         r:=rune(c)
         if class.check(r){
            fmt.sbprint(&builder,r)
            char_properties[c]|={class.char_property}
         }
      }
      fmt.printfln("Class %s %%%v = %q",class.name,class.short,strings.to_string(builder))
   }
   fmt.println("\nMy classes:")
   for class in my_classes{
      strings.builder_reset(&builder)
      for c in 0..=255{
         if class.check(u8(c)){
            fmt.sbprint(&builder,rune(c))
         }
      }
      fmt.printfln("Class %s %%%v = %q",class.name,class.short,strings.to_string(builder))
   }
   fmt.println("\n")
   is_correctly_substituted:=true
   for c in 0..=255{
      p:=char_properties[c]
      if (p&{.l,.u}!={})!=(p&{.a}!={}){
         is_correctly_substituted=false
         fmt.println("lu!=p",c)
      }
      char_properties[c]&=~{.a}
      if (p&{.x}!={})!=(p&{.g}!={}){
         is_correctly_substituted=false
         fmt.println("x!=g",c)
      }
      char_properties[c]&=~{.g}
   }
   if is_correctly_substituted{
      fmt.println("@rodata char_properties:=[256]Char_Properties{")
      for c in 0..=255{
         fmt.printfln("   0x%02X=%w,//%q",c,char_properties[c],rune(c))
      }
      fmt.println("}")
   }
}
