(ql:quickload "str")

(defun read-file (file-name)
  (with-open-file (stm file-name)
    (loop for line = (read-line stm nil)
          while line
          collect line)))

(let ((pairs (mapcar (lambda (p) (str:split "-" p)) (read-file "sample.txt")))
     (connections (make-hash-table)))
  (mapcar (lambda (p) (
    (let ((fst (car p))
          (snd (cadr p)))
          (let (fst-hash (gethash fst connections))
          (snd-hash (gethash snd connections)))
      (if fst-hash
        (setf (gethash fst connections) (cons '(snd) fst-hash))
        (setf (gethash fst connections) '(snd)))
      (if snd-hash
        (setf (gethash snd connections) (cons '(fst) snd-hash))
        (setf (gethash snd connections) '(fst))))
  )) pairs)
  connections)