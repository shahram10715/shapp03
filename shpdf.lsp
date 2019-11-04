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

(defun dtr (x)
	(* pi (/ x 180.0)))

(defun c:shpdf ()
	(setq pt1 (getpoint "\nEnter the first corner of page...\n"))
	(setq pt2 (getpoint "Enter the second corner of page...\n"))
	(setq xsp 2)
	(setq ysp 2)
	(setq delx (- (car pt2) (car pt1)))
	(setq dely (- (cadr pt2) (cadr pt1)))
	(setq delx (abs delx))
	(setq dely (abs dely))
	(setq delx (+ delx xsp))
	(setq dely (+ dely ysp))
	(setq oldsnap (getvar "osmode"))
	(setvar "osmode" 0)	
	(setq pt1t (polar pt1 (dtr 0) delx))
	(setq pt2t (polar pt2 (dtr 0) delx))
	(setq pt1t pt1)
	(setq pt2t pt2)
	(setq sel1 (ssget "w" pt1t pt2t))
	
	(while (/= sel1 nil)
		(princ "new sheet...\n")
		(setq pt1t (polar pt1t (dtr 0.0) delx))
		(setq pt2t (polar pt2t (dtr 0.0) delx))
		(setq sel1 (ssget "w" pt1t pt2t)))
	
	(setq sel2 (ssget "w" pt1t pt2t))




