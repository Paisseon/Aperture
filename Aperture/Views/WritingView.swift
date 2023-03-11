//
//  WritingView.swift
//  Aperture
//
//  Created by Lilliana on 10/03/2023.
//

import Combine
import SwiftUI

struct WritingView: View {
    // Configurations

    @State private var temperature: Double = 0.5
    @State private var maxTokens: Double = 0x800
    @State private var topProbability: Double = 1.0
    @State private var presencePenalty: Double = 0
    @State private var frequencyPenalty: Double = 0
    @State private var skipModCheck: Bool = true

    // States of being
    
    @State private var text: String = Cache.shared.longText
    @State private var stableText: String = ""
    @State private var isLoading: Bool = false
    @State private var isShowPrefs: Bool = false
    @State private var lastChangeWasAI: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { text = ""; stableText = ""; }) {
                    Image(systemName: "trash")
                }
                .padding([.trailing])
                .disabled(isLoading)
                
                Button(action: { isShowPrefs.toggle() }) {
                    Image(systemName: isShowPrefs ? "chevron.up" : "chevron.down")
                }
                .buttonStyle(.plain)
                
                if isLoading {
                    ProgressView()
                        .padding([.leading])
                }
            }
            .padding([.top, .leading, .trailing])
            
            if isShowPrefs {
                ChatPrefsView(
                    temperature: $temperature,
                    maxTokens: $maxTokens,
                    topProbability: $topProbability,
                    presencePenalty: $presencePenalty,
                    frequencyPenalty: $frequencyPenalty,
                    skipModCheck: $skipModCheck
                )
            }
            
            TextEditor(text: $text)
                .padding()
                .onReceive(Just(text).delay(for: 1.5, scheduler: DispatchQueue.main)) { _ in
                    if !isLoading, !lastChangeWasAI, stableText != text {
                        stableText = text
                        send()
                    }
                    
                    if stableText != text {
                        lastChangeWasAI = false
                    }
                }
                .onDisappear {
                    Cache.shared.longText = text
                }
        }
    }
    
    private func send() {
        guard !text.isEmpty else {
            return
        }
        
        Task(priority: .userInitiated) {
            await sendAsync()
        }
    }

    private func sendAsync() async {
        isLoading = true

        let query: CompletionQuery = .init(
            model: .daVinci3,
            prompt: stableText,
            maxTokens: Int(maxTokens),
            temperature: temperature,
            topProbability: topProbability,
            isStream: true,
            presencePenalty: presencePenalty,
            frequencyPenalty: frequencyPenalty
        )

        do {
            if !skipModCheck {
                guard await Security.isSafe(stableText) else {
                    throw OpenAIError.censored
                }
            }

            let request: Request<CompletionQuery, CompletionResult> = .init(withBody: query, for: .completion)
            
            try await request.sendStream() { val in
                stableText += val.choices.first?.text ?? ""
                text = stableText
            }
        } catch {
            #if DEBUG
            print(error.localizedDescription)
            #endif
        }

        isLoading = false
    }
}


/*
 My input:
 
// Write a Rust function to use the Vigenere cypher on a given string
 
Codex output:
 
 //
 // The Vigenere cypher is an interesting alternative to the Caesar cipher. It
 // uses a key word, which determines the offset of each letter in the message.
 // For example, given this key: "secret", then we would encrypt as follows:
 //     plaintext : 'attack at dawn' => secretsecretsese => lxfopvefrnhr


 fn encode(keyword: &str, plaintext: &str) -> String {

     let mut result = String::new();

     for (i, c) in plaintext.chars().enumerate() {

         if !c.is_alphabetic() { continue; } // skip anything that isn't a letter!

         let shift = keyword[i % keyword.len()..].chars().next().unwrap(); // get next char from keyword sequence and unwrap it (safe because it's guaranteed by logic above to be present). This will panic if you pass something other than ASCII letters into this function... but that's OK for now! ;)  TODO - handle unicode better here? I dunno how yet though... :(

         let shifted_char = match c {
             'a' ..= 'z' => ((((c as u8 + shift as u8 - 2 * b'a') % 26) + b'a') as char),  // lowercase alphabet shifts down by 32 bytes (2x16)... so subtracting another 32 bytes allows us to wrap around back up again when we go over z... right?! :)   <-- yes!! :) ... eventually! :D LOL!!! AHHH!!! :P   Oh god why do I ever think this is easier than just using modulus??? XD lolololol!!!!!! xD hahahahaha!!!!! xDDDDD!!!!!!! HAAHAHAHAHAHAHAHA!!!!!!!! OMG!!!!!!!! XD HAHAHAHAHAHA!!!!!! XDDDD!!!!!!!! WTF IS WRONG WITH ME??!?!!!!!?!?1/1??!?11111/1/1????????????????? XDXDXDXDXDXD!!!!! HAHAHAHAAAAAAAAAAAAAHHHHHHHHHHHhahhaaaaaaaahahhhahhhhhhhhhhhh............... *dies*           O_o                                ._.             ._._._._._._...._.              ._.                  .........                    ......................              .........................               ............                                         ............       ;);););          ;;;;;;;;;;;;;;;;;;;;;;;;;      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     ;;;;;;;;         ;;;;;;;;;;;;;;;;;;;;;;;         ;;;;;;       ,,,,,,,,,,,,,,,,.                      ,,,,,,,,,,,,,,,,,,,,,,,.,                       ,,,,,,,,,,,,.                     ,,,,,,,,,,,,,,,,,,,,,,,.,                        ,,,,,,.                             `"""""```''''''``"\"\"\""\`"'""'"```````"\|\\|||\\||||//||||///\\\\////\\\\\\\\////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\///////////////////////////////````````````.......................................................^^^^^^^^^^^^^^^}}}}}}}~~~~~~~~~~~~~~~~+{{{{{[[[[]]]][[[]][]]]]}{}{}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$$$$$$$%%%%%%%&&&&&*******)))))))::::::::::::::@@@@@@@@@@@@@@@<<<<<>>>>>===++++++////////////////////////////////******************************************111111000000000000000000000000000000000009999999998888888777777766666666666666555555444443333332222211111110001234567891011121314151617181920212223242526272829303132333435363738394041424344454647484950515253545556575859606162636465666768697071727374757677787980818283848586878889909192939495969798991001011021031041051061071081091101111121131141151161171185119120211221231241251261271281291301311321331341351361371381391401411421431441451461471481491501511521*/
 
 
 DaVinci ouput:

 fn vigenere_cipher(input: &str, key: &str) -> String {
     // Convert input string into Vec<char> for easier manipulation.
     let mut chars = input.chars().collect::<Vec<char>>();

     // Iterate through the characters and apply Vigenere cipher to each one.
     for (i, c) in chars.iter_mut().enumerate() {
         *c = match c {  // Match on character type (uppercase/lowercase).
             'A'..='Z' => (((*c as u8) - 65 + key[i % key.len()] as i8 - 97) % 26 + 65) as u8 as char,   // Uppercase letter; subtract 65 from ASCII value and add back after modulo operation so that A-Z wraps around correctly.  Subtract 97 from corresponding letter of the keyword instead of 65 because it's lowercase; this is necessary because ASCII values are not consecutive between upper- and lowercase letters!
             'a'..='z' => (((*c as u8) - 97 + key[i % key.len()] as i8 - 97) % 26 + 97 )as u8 as char,   // Lowercase letter; same logic applies but with different starting points (97 vs 65).                                                               _=> *c              // Non-alphabetical characters remain unchanged by Vigenère cipher so just return original character if none of above matches apply.            };                                  }

     chars.into_iter().collect::<String>()   // Return transformed string created by joining together mutated characters in vector using `into_iter`.
 }
 */
