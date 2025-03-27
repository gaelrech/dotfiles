(ns ignore
  (:require ["ext://betterthantomorrow.calva$v1" :as calva]
            ["vscode" :as vscode]
            [promesa.core :as p]
            [util.editor :as e]))

(def ignore-form "#_")

(defn cursor-inside-ignore-form
  [^js current-form
   ^js editor
   ^js original-selection]
  (p/let [next-selection-form (p/do (vscode/commands.executeCommand "paredit.selectForwardSexpOrUp")
                                    (e/current-selection))
          previous-selection-form (p/do (e/selection->set-index editor original-selection)
                                        (vscode/commands.executeCommand "paredit.selectBackwardSexpOrUp")
                                        (e/current-selection))
          next-selection-text (p/do (e/selection->set-index editor original-selection)
                                    (e/selection->get-text next-selection-form editor))
          previous-selection-text (e/selection->get-text previous-selection-form editor)]
    (cond
      (= next-selection-text ignore-form) next-selection-form
      (= previous-selection-text ignore-form) previous-selection-form
      (= (str previous-selection-text next-selection-text) ignore-form) (e/selection->range original-selection (e/selection->start previous-selection-form) (e/selection->end next-selection-form))
      :else current-form)))

(defn cursor-inside-symbol-form
  [^js current-form
   ^js editor
   ^js original-selection]
  (p/let [position-start-fn #(max 0 (- (e/position->character %) (count ignore-form)))
          previous-form (p/do (e/selection->set-index editor original-selection)
                              (vscode/commands.executeCommand "paredit.backwardSexpOrUp")
                              (e/selection->select-offset-character-position (e/current-selection) position-start-fn e/position->character))
          previous-text (p/do (e/selection->set-index editor original-selection)
                              (e/selection->get-text previous-form editor))]
    (if (= previous-text ignore-form)
      previous-form
      current-form)))

(defn get-current-form
  [^js editor
   ^js original-selection]
  (p/let [_ (vscode/commands.executeCommand "paredit.sexpRangeExpansion")
          current-form (e/current-selection)
          _ (e/selection->set-index editor original-selection)]
    current-form))

(p/let [editor ^js vscode/window.activeTextEditor
        original-selection (e/current-selection)
        selection (p/-> (get-current-form editor original-selection)
                        (cursor-inside-ignore-form editor original-selection)
                        (cursor-inside-symbol-form editor original-selection))
        selection-text (.getText (.-document editor) selection)]
  (if (= "#_" selection-text)
    (calva/editor.replace vscode/window.activeTextEditor selection "")
    (calva/editor.replace vscode/window.activeTextEditor selection (str "#_" selection-text))))



