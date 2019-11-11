;This program is free software: you can redistribute it and/or modify
;it under the terms of the GNU General Public License as published by
;the Free Software Foundation, either version 3 of the License, or
;(at your option) any later version.
;
;This program is distributed in the hope that it will be useful,
;but WITHOUT ANY WARRANTY; without even the implied warranty of
;MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;GNU General Public License for more details.
;
;You should have received a copy of the GNU General Public License
;along with this program.  If not, see <https://www.gnu.org/licenses/>.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;Execute the following command to see the order of needed inputs:
; (command "_plot")
;For ploter name it should be DWG TO PDF.PC3, since it is the built-in plotter.
;(command "_plot" "y" "Model" "DWG TO PDF.PC3" "ISO full bleed A2 (420.00 x 594.00 MM)" "M"
;			"L" "N" "W" pt1 pt2 "F" "C" "Y" "acad.ctb" "Y" "W" "123" "N" "Y")



(defun dtr (x)
	(* pi (/ x 180.0)))

(defun myplot (pt1 pt2 pgn)
	(command "_plot" "y" "Model" "DWG TO PDF.PC3" "ISO full bleed A2 (420.00 x 594.00 MM)" "M"
			"L" "N" "W" pt1 pt2 "F" "C" "Y" "acad.ctb" "Y" "W" pgn "N" "Y"))

(defun c:shpdf ()
	(setq pt1 (getpoint "\nEnter the first corner of page...\n"))
	;(setq pt1 (list 1.0 253.0 0.0))
	(setq pt2 (getpoint "Enter the second corner of page...\n"))
	;(setq pt2 (list 58.4 293.0 0.0))
	(command "zoom" "e")
	(setq xsp 2.0)
	(setq ysp 2.0)
	(setq delx (- (car pt2) (car pt1)))
	(setq dely (- (cadr pt2) (cadr pt1)))
	(setq delx (abs delx))
	(setq dely (abs dely))
	(setq delx (+ delx xsp))
	(setq dely (+ dely ysp))
	(setvar "osmode" 0)
	(setq pt1r pt1)
	(setq pt2r pt2)
	(setq selr (ssget "w" pt1 pt2))
	;(princ (sslength selr))
	(setq r 1)
	(while (/= selr nil)
		(setq pt1r (polar pt1r (dtr 0.0) (* r delx)))
		(setq pt2r (polar pt2r (dtr 0.0) (* r delx)))
		(setq selr nil)
		(setq selr (ssget "w" pt1r pt2r))
		(setq r (+ 1 r)))
	(princ r)
	(setvar "osmode" 15359)
	(princ))
