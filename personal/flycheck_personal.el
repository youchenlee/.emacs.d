;;; personal - summary
;;; My personal ls settings:
;(setq debug-on-error t)

(add-to-list 'load-path
             "~/.emacs.d/mymodules/yasnippet")

(require 'yasnippet)
(yas-global-mode 1)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"                 ;; personal snippets
        "~/.emacs.d/mymodules/yasnippet/yasmate/snippets" ;; the yasmate collection
        "~/.emacs.d/mymodules/yasnippet/snippets"         ;; the default collection
        ))
;(define-key yas-minor-mode-map (kbd "<tab>") nil)
;(define-key yas-minor-mode-map (kbd "TAB") nil)
;(define-key yas-minor-mode-map (kbd "C-c C-c") 'yas-expand)


(defun ca-with-comment (str)
  (format "%s%s%s" comment-start str comment-end))


(require 'auto-complete)
(require 'yasnippet)

;(add-to-list 'load-path
;             "~/.emacs.d/mymodules/php-auto-yasnippets")
;(require 'php-auto-yasnippets)
;(setq php-auto-yasnippet-php-program "~/.emacs.d/mymodules/php-auto-yasnippets/Create-PHP-YASnippet.php")
;(define-key php-mode-map (kbd "C-c C-c") 'yas/create-php-snippet)

(add-hook 'js2-mode-hook 'ac-js2-mode)
(add-to-list 'auto-mode-alist '("\\.ls\\'" . coffee-mode))
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/") t)

;; Org-mode
(add-to-list 'auto-mode-alist '("\\.org\\.txt$" . org-mode))

;; Php-mode
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

(add-hook 'php-mode-hook 'my-php-mode-hook)
(defun my-php-mode-hook ()
  "My PHP mode configuration."
  (setq indent-tabs-mode t
        tab-width 4
        c-basic-offset 4))


(add-hook 'web-mode-hook 'my-web-mode-hook)
(defun my-web-mode-hook ()
  "My WEB mode configuration."
  (setq indent-tabs-mode t
        tab-width 4
        c-basic-offset 4))

;; Set to the location of your Org files on your local system
(setq org-directory "~/Cloud Drive/10_ORG")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/Dropbox/10_ORG/flagged.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")


;; flycheck
;(setq flycheck-check-syntax-automatically '(save
;                                            idle-change
;                                            mode-enabled))

(setq flycheck-idle-change-delay 2.0)
(make-variable-buffer-local 'flycheck-idle-change-delay)

;(defun flycheck-handle-idle-change ()
;  "Handle an expired idle time since the last change.
;
;This is an overwritten version of the original
;flycheck-handle-idle-change, which removes the forced deferred.
;Timers should only trigger inbetween commands in a single
;threaded system and the forced deferred makes errors never show
;up before you execute another command."
;  (flycheck-clear-idle-change-timer)
;  (flycheck-buffer-automatically 'idle-change))

(setq prelude-flyspell nil)

(defun comment-or-uncomment-line ()
  "Comments or uncomments the current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position))
)

(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end))
    (redraw-display)
)


; No use, why?
(global-unset-key (kbd "C-;"))
(global-set-key (kbd "C-;") 'comment-or-uncomment-region-or-line)

(key-chord-define-global "cc" 'comment-or-uncomment-region-or-line)

(defun my-web-mode-setup ()
    (setq comment-start "<!-- ")
    (setq comment-end " -->")
    (key-chord-define-global "cc" 'web-mode-comment-or-uncomment)
    (global-set-key (kbd "C-;") 'web-mode-comment-or-uncomment)
)
(add-hook 'web-mode-hook 'my-web-mode-setup)

(define-key input-decode-map "\e[1;10A" [M-S-up])
(define-key input-decode-map "\e[1;10B" [M-S-down])
(define-key input-decode-map "\e[1;10C" [M-S-right])
(define-key input-decode-map "\e[1;10D" [M-S-left])

(define-key input-decode-map "\e[1;9A" [M-up])
(define-key input-decode-map "\e[1;9B" [M-down])
(define-key input-decode-map "\e[1;9C" [M-right])
(define-key input-decode-map "\e[1;9D" [M-left])

(setq org-todo-keywords
  '((sequence "DRAFT" "TODO" "IN-PROGRESS" "|" "DONE")))


;; swank-js settings

;;(autoload 'js2-mode "js2-mode" nil t)
;;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;;(global-set-key [f5] 'slime-js-reload)
;;(add-hook 'js2-mode-hook
   ;;(lambda ()
   ;;(slime-js-minor-mode 1)))

(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
   '(add-to-list 'ac-modes 'slime-repl-mode))


(setq ac-js2-evaluate-calls t)

(add-hook 'js2-mode-hook 'ac-js2-mode)
`(setq ac-js2-evaluate-calls t)'

; swank http://stackoverflow.com/questions/13778399/can-i-use-swank-js-to-complete-node-js-apis-in-js2-mode
(eval-after-load 'auto-complete
  '(progn
     (add-to-list 'ac-modes 'slime-repl-mode)
     (add-to-list 'ac-modes 'js2-mode)
     (add-to-list 'ac-modes 'js-mode)
     (add-hook 'slime-mode-hook 'set-up-slime-ac)
     (ac-set-trigger-key "TAB")
     (setq ac-auto-show-menu 0.7)
     (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)))

(eval-after-load 'slime
  '(progn
     (setq slime-protocol-version 'ignore
           slime-net-coding-system 'utf-8-unix
           slime-complete-symbol*-fancy t
           slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
     (slime-setup '(slime-repl slime-js))))



;; http://blog.deadpansincerity.com/2011/05/setting-up-emacs-as-a-javascript-editing-environment-for-fun-and-profit/
(require 'auto-complete-config)
; Make sure we can find the dictionaries
(add-to-list 'ac-dictionary-directories "~/emacs/auto-complete/dict")
; Use dictionaries by default
(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))
(global-auto-complete-mode t)
; Start auto-completion after 2 characters of a word
(setq ac-auto-start 2)
; case sensitivity is important when finding matches
(setq ac-ignore-case nil)

;(disable-theme 'zenburn)
;(load-theme 'subatomic256 t)
;(load-theme 'tsdh-dark t)
;(load-theme 'manoj-dark t)


; from: https://github.com/dconnolly/emacs.d/blob/master/init.el
(defvar background-color "black") ;; Black renders as transparent if
                                  ;; your terminal supports it.
(defvar foreground-color "gray20")
(defvar violation-foreground-color "chartreuse1")
(set-face-attribute 'whitespace-space nil
                    :background background-color
                    :foreground foreground-color)
(set-face-attribute 'whitespace-hspace nil
                    :background background-color
                    :foreground foreground-color)
(set-face-attribute 'whitespace-tab nil
                    :background background-color
                    :foreground foreground-color)
(set-face-attribute 'whitespace-newline nil
                    :background background-color
                    :foreground foreground-color)
(set-face-attribute 'whitespace-trailing nil
                    :background background-color
                    :foreground violation-foreground-color)
(set-face-attribute 'whitespace-line nil
                    :background background-color
                    :foreground violation-foreground-color)
(set-face-attribute 'whitespace-space-before-tab nil
                    :background background-color
                    :foreground violation-foreground-color)
(set-face-attribute 'whitespace-indentation nil
                    :background background-color
                    :foreground violation-foreground-color)
(set-face-attribute 'whitespace-empty nil
                    :background background-color
                    :foreground violation-foreground-color)
(set-face-attribute 'whitespace-space-after-tab nil
                    :background background-color
                    :foreground violation-foreground-color)


;; Set to the location of your Org files on your local system
(setq org-directory "~/Dropbox/10_ORG")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/Dropbox/10_ORG/flagged.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")

;(setq indent-tabs-mode t
;      tab-width 4
;      c-basic-offset 4)


(add-hook 'before-save-hook 'delete-trailing-whitespace)

(provide 'personal)
;;; personal.el ends here
