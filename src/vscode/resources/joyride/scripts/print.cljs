(ns print
  (:require ["ext://betterthantomorrow.calva$v1" :as calva]
            ["vscode" :as vscode]
            [promesa.core :as p]
            [util.editor :as editor]
            [clojure.string :as str]))

(def reader "#p")

(p/let [editor ^js vscode/window.activeTextEditor
        original-selection (editor/current-selection)
        _ (vscode/commands.executeCommand "paredit.sexpRangeExpansion")
        target-form (editor/current-selection)
        text (.getText (.-document editor) target-form)]
  (aset editor "selection" original-selection)
  (if (str/starts-with? text reader)
    (calva/editor.replace vscode/window.activeTextEditor target-form (str/replace text (re-pattern (str reader "\\s+")) ""))
    (calva/editor.replace vscode/window.activeTextEditor target-form (str reader " " text))))
