(define (pad-string str width ch)
  (if (= width (string-length str))
    str
    (pad-string (string-append ch str) width ch)))

(define (hex-to-bin str)
  (string-join (map 
    (lambda (c) 
      (pad-string (number->string (string->number (string c) 16) 2) 4 "0"))
      (string->list str))
  ""))
