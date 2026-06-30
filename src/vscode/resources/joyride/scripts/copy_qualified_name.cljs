(ns copy-qualified-name
  (:require ["vscode" :as vscode]
            [promesa.core :as p]))

(defn- flatten-symbols
  "Recursively flattens a DocumentSymbol tree into a seq."
  [syms]
  (when syms
    (reduce (fn [acc i]
              (let [^js sym (aget syms i)]
                (into acc (cons sym (flatten-symbols (.-children sym))))))
            []
            (range (.-length syms)))))

(defn- flash! [editor range color]
  (let [deco (vscode/window.createTextEditorDecorationType
               #js {:backgroundColor color :borderRadius "3px"})]
    (.setDecorations editor deco #js [range])
    (js/setTimeout #(.dispose deco) 600)))

(let [editor ^js vscode/window.activeTextEditor]
  (if-not editor
    (vscode/window.showWarningMessage "No active editor")
    (let [doc        (.-document editor)
          pos        (.. editor -selection -active)
          word-range (.getWordRangeAtPosition doc pos #"[\w\-!?*+><=']+")
          word       (when word-range (.getText doc word-range))
          text       (.getText doc)
          ns-match   (.match text #"\(\s*ns\s+([\w.\-]+)")]
      (if-not (and word ns-match)
        (vscode/window.showWarningMessage "Could not find symbol or namespace")
        (p/let [symbols (vscode/commands.executeCommand "vscode.executeDocumentSymbolProvider"
                                                        (.-uri doc))]
          (let [all-syms  (flatten-symbols symbols)
                target    (some #(when (.contains (.-selectionRange %) pos) %) all-syms)
                ;; SymbolKind: Method=5, Function=11, Variable=12, Constant=13
                def-like? (and target (contains? #{5 11 12 13} (.-kind target)))]
            (if-not def-like?
              (do
                (flash! editor word-range "rgba(220, 50, 50, 0.4)")
                (vscode/window.setStatusBarMessage "✗ Not a def/defn" 3000))
              (let [namespace (aget ns-match 1)
                    qualified (str namespace "/" word)]
                (flash! editor word-range "rgba(80, 200, 80, 0.35)")
                (p/let [_ (vscode/env.clipboard.writeText qualified)]
                  (vscode/window.setStatusBarMessage (str "✓ Copied: " qualified) 3000))))))))))
