(ns chiton
  (:require [clojure.string :as str]))

(defn get-input
  [filename]
  (vec 
   (map 
    (fn [row] 
      (vec 
       (map 
        (fn [c] 
          (Character/digit c 10)) 
        (seq row)))) 
    (str/split (slurp filename) #"\n"))))

(defn get-neighbors
  [row col row-max col-max]
  (filter some? (vector 
   (when (< col col-max) (vector row (+ col 1)))
   (when (< row row-max) (vector (+ row 1) col))
   (when (> row 0) (vector (- row 1) col))
   (when (> col 0) (vector row (- col 1))))))

(defn risk-map
  [vals]
  (into {} 
        (for [r (range (count vals)) c (range (count (vals 0)))] 
          (vector [r c] ((vals r) c)))))

(defn neighbors-map
  [coords]
  (let [[row-max col-max] (last (sort coords))]
    (into {} 
          (map 
           (fn [p] 
             (vector p (get-neighbors (first p) (second p) row-max col-max))) 
           coords))))

(defn update-scores
  [risk-vals neighbors current scores unvisited]
  (let [ns (filter (fn [n] (contains? unvisited n)) (neighbors current))]
      (loop [new-ns ns
             s scores
             current-score (s current)]
        (if (empty? new-ns)
          s
          (let [neighbor (first new-ns)
                new-score (min (s neighbor) (+ (s current) (risk-vals neighbor)))]
            (recur (rest new-ns) (assoc s neighbor new-score) current-score))))))

(defn part1
  [filename]
  (let [risk-vals (risk-map (get-input filename))
        neighbors (neighbors-map (keys risk-vals))
        inf (Long/MAX_VALUE)]
    (loop
     [current [0 0]
      unvisited (disj (apply hash-set (keys risk-vals)) current)
      scores (assoc (zipmap unvisited (repeat inf)) current 0)]
      (if (or (empty? unvisited) (= inf (scores current)))
        scores
        (let [new-scores (update-scores risk-vals neighbors current scores unvisited)
              new-current (first (sort-by new-scores unvisited))
              new-unvisited (disj unvisited new-current)]
          (recur new-current new-unvisited new-scores))))))

(defn incr-row
  [row]
  (map (fn [n] (+ 1 n)) row))

(defn wrap-nine
  [row]
  (map (fn [n] (if (> n 9) (- n 9) n)) row))


(defn expand-row
  [grid]
  (into [] (map
   (fn [r]
     (loop [row r
            new-row (incr-row row)
            times-left 4
            acc r]
       (if (= times-left 0)
         (into [] (wrap-nine acc))
         (recur new-row (incr-row new-row) (- times-left 1) (concat acc new-row)))))
   grid)))

(defn expand-grid
  [grid]
  (into []
        (loop [sec grid
               new-sec (map incr-row sec)
               times-left 4
               acc grid]
          (if (= times-left 0)
            (map (fn [r] (into [] (wrap-nine r))) acc)
            (recur new-sec (map incr-row new-sec) (- times-left 1) (concat acc new-sec))))))

(defn part2
  [filename]
  (let [risk-vals (risk-map (expand-grid (expand-row (get-input filename))))
        neighbors (neighbors-map (keys risk-vals))
        inf (Long/MAX_VALUE)]
    (loop
     [current [0 0]
      unvisited (disj (apply hash-set (keys risk-vals)) current)
      scores (assoc (zipmap unvisited (repeat inf)) current 0)]
      (if (or (empty? unvisited) (= inf (scores current)))
        scores
        (let [new-scores (update-scores risk-vals neighbors current scores unvisited)
              new-current (first (sort-by new-scores unvisited))
              new-unvisited (disj unvisited new-current)]
          (recur new-current new-unvisited new-scores))))))

;;(last (sort (part1 "../sample.txt")))
;;(last (sort (part1 "../input.txt")))
;;(last (sort (part2 "../sample.txt")))
(last (sort (part2 "../input.txt")))