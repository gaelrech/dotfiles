(ns util.editor
  (:require ["vscode" :as vscode]
            [promesa.core :as p]))

(defn position->character
  [^js position]
  (.-character position))

(defn position->line
  [^js position]
  (.-line position))

(defn position->new
  [^js position
   line
   character]
  (.with position line character))

(defn selection->get-text
  [^js selection
   ^js editor]
  (.getText (.-document editor) selection))

(defn selection->position
  [^js selection]
  (.-active selection))

(defn selection->range
  [^js selection
   ^js start
   ^js end]
  (.with selection start end))

(defn selection->start
  [^js selection]
  (.-start selection))

(defn selection->end
  [^js selection]
  (.-end selection))

(defn selection->set-index
  [^js editor
   ^js new-selection]
  (aset editor "selection" new-selection))

(defn selection->select-offset-character-position
  [^js selection
   start-f
   end-f]
  (p/let [position (selection->position selection)
          start-position (position->new position (position->line position) (start-f position))
          end-position (position->new position (position->line position) (end-f position))]
    (.with selection start-position end-position)))

(defn current-selection []
  (let [editor ^js vscode/window.activeTextEditor
        selection (.-selection editor)]
    selection))

(defn current-document []
  (let [editor ^js vscode/window.activeTextEditor
        document (.-document editor)]
    document))

(defn current-selection-text []
  (.getText (current-document) (current-selection)))

(defn insert-text!+
  ([^js text]
   (insert-text!+ text vscode/window.activeTextEditor (.-active (current-selection))))
  ([text ^js editor ^js position]
   (-> (p/do (.edit editor
                    (fn [^js builder]
                      (.insert builder position text))
                    #js {:undoStopBefore true :undoStopAfter false}))
       (p/catch (fn [e]
                  (js/console.error e))))))

(defn delete-range!+
  [^js editor ^js range]
  (-> (p/do (.edit editor
                   (fn [^js builder]
                     (.delete builder range))
                   #js {:undoStopBefore true :undoStopAfter false}))
      (p/catch (fn [e]
                 (js/console.error e)))))

(def delete-range! delete-range!+) ;; backwards compatible

(defn replace-range!+
  "Defaults to the current selection."
  ([^js text]
   (replace-range!+ text vscode/window.activeTextEditor (.-active (current-selection)) (current-selection)))
  ([^js text ^js editor ^js position ^js range]
   (-> (p/do (.edit editor
                    (fn [^js builder]
                      (.delete builder range)
                      (.insert builder position text))
                    #js {:undoStopBefore true :undoStopAfter false}))
       (p/catch (fn [e]
                  (js/console.error e))))))

