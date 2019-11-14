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
;This code makes pdf from left to right, and up to down



(defun dtr (x)
  (* pi (/ x 180.0))
)

(defun myplot (pt1 pt2 pgno)
  (command "_plot"	   "y"		   "Model"
	   "DWG TO PDF.PC3"
	   "ISO full bleed A2 (420.00 x 594.00 MM)"
	   "M"		   "L"		   "N"
	   "W"		   pt1		   pt2
	   "F"		   "C"		   "Y"
	   "acad.ctb"	   "Y"		   "W"
	   pgno		   "N"		   "Y"
	  )
)

(defun c:shpdf ()
  (setq pt1 (getpoint "\nEnter the first corner of page...\n"))
  (setq pt2 (getpoint "Enter the second corner of page...\n"))
  (setq xsp (getdist "horizontal distance between sheets: "))
  (setq ysp (getdist "vertical distance between sheets: "))
  (command "zoom" "e")
  (setq delx (- (car pt2) (car pt1)))
  (setq delx (abs delx))
  (setq delx (+ delx xsp))
  (setq dely (- (cadr pt2) (cadr pt1)))
  (setq dely (abs dely))
  (setq dely (+ dely ysp))
  (setq oldsnap (getvar "osmode"))
  (setvar "osmode" 0)
  (setq pt1r pt1)
  (setq pt2r pt2)
  (setq pt1c pt1)
  (setq pt2c pt2)
  (setq selr (ssget "w" pt1r pt2r))
  (setq selc (ssget "w" pt1c pt2c))
  (setq pgnumber 0)
  (while (/= selc nil)
    (while (/= selr nil)
      (myplot pt1r pt2r pgnumber)
      (setq pgnumber (1+ pgnumber))
      (setq pt1r (polar pt1r (dtr 0.0) delx))
      (setq pt2r (polar pt2r (dtr 0.0) delx))
      (setq selr nil)
      (setq selr (ssget "w" pt1r pt2r))
    )
    (setq pt1c (polar pt1c (dtr 270.0) dely))
    (setq pt2c (polar pt2c (dtr 270.0) dely))
    (setq pt1r pt1c)
    (setq pt2r pt2c)
    (setq selr nil)
    (setq selr (ssget "w" pt1r pt2r))
    (setq selc nil)
    (setq selc (ssget "w" pt1c pt2c))
  )
  (setvar "osmode" oldsnap)
  (princ)
)
