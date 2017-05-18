;; melpa源
(when (>= emacs-major-version 24)
    (require 'package)
    (package-initialize)
    (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                     ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

;; cl - Common Lisp Extension
(require 'cl)

;; 添加 Org-mode 文本内语法高亮
(require 'org)
(setq org-src-fontify-natively t)

;; Add Packages
(defvar my/packages '(
               ;; --- Auto-completion ---
               company
               ;; --- Better Editor ---
	       org
	       helm
	       yasnippet
	       magit
	       smex
	       hungry-delete
	       smartparens
	       popwin
	       ;; --- Major Mode ---
	       markdown-mode
               ) "Default packages")

(setq package-selected-packages my/packages)

(defun my/packages-installed-p ()
  (loop for pkg in my/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))


(unless (my/packages-installed-p)
  (message "%s" "welcome cheng33c...")
  (package-refresh-contents)
  (dolist (pkg my/packages)
    (when (not (package-installed-p pkg))
(package-install pkg))))

;; 开启插件
(global-hungry-delete-mode)
(smartparens-global-mode t)
(global-company-mode t)
(require 'popwin)
(popwin-mode t)

;; 文件末尾
(provide 'init-packages)
