;; extends

(curly_group_text_list) @punctuation.bracket

(curly_group_text_list
  (text
    word: (word) @variable))

(brack_group_key_value
  (key_value_pair)
  "," @punctuation.delimiter)
