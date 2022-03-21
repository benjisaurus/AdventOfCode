(ns packet
  (:require [clojure.string :as string]))

(defn hex-bi
  [ch]
  (string/replace 
   (format "%4s" (Integer/toBinaryString (Integer/parseInt (str ch) 16)))
   " " "0"))

(defn hex-bi-str
  [str]
  (string/join (map hex-bi str)))