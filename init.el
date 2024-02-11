;; .emacs.d/init.el

;; ==============================
;; MELPA Package Support
;; ==============================

;; Enables basic packaging support
(require 'package)

;; Adds the Melpa archive to the list of available repositories
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

;; Initializes the package infraestructure
(package-initialize)

;; Keeps Emacs from automatically making packages available at startup
(setq package-enable-at-startup nil)

;; Downloads use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; ==============================
;; Basic Customization
;; ==============================

;;(setq inhibit-startup message t)        ; hides the startup message
(tool-bar-mode -1)                      ; disables toolbar
;;(menu-bar-mode -1)                    ; disables menu bar
;;(scroll-bar-mode -1)                  ; disables scroll bar
;;(global-linum-mode t)                 ; enables line numbers globally

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(delete-selection-mode nil)
 '(package-selected-packages
   '(py-autopep8 flycheck markdown-mode slime which-key use-package)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Enable wich-key
(use-package which-key
  :ensure t
  :init
  (which-key-mode))

;; Enable global-flycheck-mode
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Define spell checker
(setq ispell-program-name "aspell")

;; Spanish RAE Dictionary lookup word at point
(defun rae (word)
    (interactive (list (current-word t t)))
    (other-window 1)
    (eww (format "https://dle.rae.es/?w=%s" word)))
(define-key global-map (kbd "M-¿") 'rae)

;; ==============================
;; Development Setup - Python
;; ==============================

;; Enable elpy
;;(elpy-enable)
(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable))

;; Enable Flycheck
(require 'elpy)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Enable autopep8
;;require 'py-autopep8)
;;add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
(use-package py-autopep8
  ;; Require zypper in python3xx-autopep8
  ;;:config
  ;;(setq py-autopep8-options '("--max-line-length=100" "--aggressive"))
  :hook ((python-mode) . py-autopep8-mode))

;; ==============================
;; Development Setup - Lisp
;; ==============================

;; sbcl
(setq inferior-lisp-program "/usr/bin/sbcl")
(put 'upcase-region 'disabled nil)

;; User-Defined init.el ends here
