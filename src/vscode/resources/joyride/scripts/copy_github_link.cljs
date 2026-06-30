(ns copy-github-link
  (:require ["vscode" :as vscode]
            ["child_process" :as cp]
            [promesa.core :as p]))

(defn- exec [cmd cwd]
  (js/Promise.
    (fn [resolve reject]
      (cp/exec cmd #js {:cwd cwd}
               (fn [err stdout _stderr]
                 (if err (reject err) (resolve (.trim stdout))))))))

(defn- flash! [editor range color]
  (let [deco (vscode/window.createTextEditorDecorationType
               #js {:backgroundColor color :borderRadius "3px"})]
    (.setDecorations editor deco #js [range])
    (js/setTimeout #(.dispose deco) 600)))

(let [editor ^js vscode/window.activeTextEditor]
  (if-not editor
    (vscode/window.showWarningMessage "No active editor")
    (let [doc       (.-document editor)
          sel       (.-selection editor)
          start-ln  (inc (.. sel -start -line))
          end-ln    (inc (.. sel -end -line))
          end-ln    (if (and (> end-ln start-ln)
                             (zero? (.. sel -end -character)))
                      (dec end-ln)
                      end-ln)
          file-path (.-fsPath (.-uri doc))
          ws-folder (aget vscode/workspace.workspaceFolders 0)]
      (if-not ws-folder
        (vscode/window.showWarningMessage "No workspace folder open")
        (let [root-path (.-fsPath (.-uri ws-folder))
              rel-path  (.substring file-path (inc (.-length root-path)))]
          (p/let [remote-url (exec "git remote get-url origin" root-path)]
            (let [match (.match remote-url #"github\.com[:/](.+?)(?:\.git)?$")]
              (if-not match
                (vscode/window.showWarningMessage "Could not parse GitHub remote")
                (let [org-repo   (aget match 1)
                      fragment   (if (= start-ln end-ln)
                                   (str "L" start-ln)
                                   (str "L" start-ln "-L" end-ln))
                      url        (str "https://github.com/" org-repo
                                      "/blob/main/" rel-path "#" fragment)]
                  (flash! editor sel "rgba(80, 200, 80, 0.35)")
                  (p/let [_ (vscode/env.clipboard.writeText url)]
                    (vscode/window.setStatusBarMessage
                      (str "✓ Copied GitHub link (" fragment ")") 3000)))))))))))
