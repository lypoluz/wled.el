;;; wled.el --- Control your WLED setup

;; Copyright (C) 2023 Dominik Potulski

;; Author: Dominik Potulski <dominik.potuslki@gmail.com>
;; Keywords: lisp
;; Version: 0.0.1

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Control your WLED setup.
;; Currently, this package only supports one wled server.
;; Implemented functions:
;;      wled-on,
;;      wled-off,
;;      wled-brightness.
;; Please set "wled-address" to the address of your wled device.




;;; Code:

(provide 'wled)
(require 'request)

(defvar wled-address "Define the WLED address")


(defun wled-get-state (action)
  "retrieves wled state."
(request (concat wled-address "/json")
  :parser 'json-read
  :success (if action (cl-function (action)))))


(defun wled-post (content action)
  "Sends a JSON POST to wled."
  (request (concat wled-address "/json/state")
  :type "POST"
  :data content
  :headers '(("Content-Type" . "application/json"))
  :parser 'json-read
  :success (if action (cl-function (action)))))



(defun wled-on ()
  "Turn on your WLED."
  (interactive)
  (wled-post (json-encode  '(("on" . t))) nil))

(defun wled-off ()
  "Turn off your WLED."
  (interactive)
  (wled-post (json-encode '(("on" . :json-false))) nil))

(defun wled-toggle ()
  "NOT IMPLEMENTED Toggles WLED between on/off."
  ;;(interactive)
  ())

(defun wled-brigtness ()
  "Sets the brightness of your WLED"
  (interactive)
  (wled-post (json-encode `(("on" . t) ("bri" . ,(read-number "Type brightness [1-255] " 128)))) nil ))

;;; wled.el ends here
