;;(defun custom-erlang-mode-hook ()
;;  (define-key erlang-mode-map (kbd "M-,") 'alchemist-goto-jump-back))

;;(add-hook 'erlang-mode-hook 'custom-erlang-mode-hook)

;; erlang distal
;;(add-hook 'after-init-hook 'my-after-init-hook)
;;(defun my-after-init-hook ()
;;  (require 'edts-start))

(add-to-list 'load-path  "/usr/local/lib/erlang/lib/tools-2.11.2/emacs")
      (setq erlang-root-dir "/usr/local/lib/erlang")
      (setq exec-path (cons "/usr/local/lib/erlang/bin" exec-path))
      (require 'erlang-start)
(add-to-list 'load-path "/Users/lorancechen/version_control_project/_open_source/distel/elisp")
(require 'distel)
(distel-setup)


;; prevent annoying hang-on-compile
(defvar inferior-erlang-prompt-timeout t)
;; default node name to emacs@localhost
(setq inferior-erlang-machine-options '("-sname" "emacs"))
;; tell distel to default to that node
(setq erl-nodename-cache
      (make-symbol
       (concat
        "emacs@"
        ;; Mac OS X uses "name.local" instead of "name", this should work
        ;; pretty much anywhere without having to muck with NetInfo
        ;; ... but I only tested it on Mac OS X.
                (car (split-string (shell-command-to-string "hostname"))))))
