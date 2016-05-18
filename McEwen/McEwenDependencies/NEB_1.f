C      You should have received a copy of the GNU Library General Public
C      License along with PLplot; if not, write to the Free Software
C      Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

      implicit none
      integer PL_PARSE_FULL, i, type
      real*8 Eb3(7), distance3(7), dummy, x(200), y(200), 
     + Eb(10), distance(10), x2(181), y2(181), Eb4(8), distance4(8), 
     + Eph6(301), xI6(301), x3(4), y3(4), lines(2), spaces(2),
     + Eph7(501), xI7(501), Eph8(301), xI8(301)
      integer mark(2), space(2) 
      parameter(PL_PARSE_FULL = 1)
      OPEN(UNIT=21, 
     +FILE='Guai_O1s.dat', 
     + status='unknown')
      OPEN(UNIT=22, 
     +FILE='GuaiV_O1s.dat', 
     + status='unknown')
       call plscol0(0,255,255,255)
       call plscol0(1,0,0,0)
       call plscol0(2,255,0,0)  
       call plscol0(3,0,0,0)
C
C      Process command-line arguments

      call plparseopts(PL_PARSE_FULL)
      call plsetopt('-ori','1')  
      call plinit() 
      call plfont(2)
      call plfontld(1)
      call pladv(0)
C     Box 1 (Right Axis)
      call plschr(0.d0,2.250d0)
      call plvpas(0.15d0, 0.83d0, 0.171d0, 0.871d0, 0.7d0)
      call plwind(0.5d0,4.5d0,529.6d0,533.6d0)
      call plschr(0.d0,1.30d0)
      call plwid(2.d0)
      call plschr(0.d0,1.25d0)
      call plbox('bc', 2.0d0,1, 'cmstv', 0.5d0,2)
      x(1)=0.0
      y(1)=533.1
      x(2)=15.0
      y(2)=533.1
      call pllsty(3)
      call plcol0(1)
      call plwid(1)
      call plline(2,x, y)
      x2(1)=0.0
      y2(1)=530.6
      x2(2)=15.0
      y2(2)=530.6
      call plstyl(1,7000,5000)
      call plcol0(1)
      call plwid(1)
      call plline(2,x2, y2)
      x3(1)=0.0
      y3(1)=532.4
      x3(2)=15.0
      y3(2)=532.4
      call plstyl(1,5000,7000)
      call plcol0(1)
      call plwid(1)
      call plline(2,x3, y3)
      call plstyl(1,1000,3000)
      call plcol0(1)
      call plwid(1)
      call plline(2,x3, y3)
C     Box 2 (Left Axis)
      call pllsty(1)
      call plschr(0.d0,2.250d0)
      call plvpas(0.15d0, 0.83d0, 0.171d0, 0.871d0, 0.7d0)
      call plwind(0.5d0,4.5d0,-3.5d0,0.5d0)
      call plschr(0.d0,1.30d0)
      call plwid(2.d0)
      call plschr(0.d0,1.25d0)
      call plbox('bc', 2.0d0,1, 'bnstv', 0.5d0,2)
      call plschr(0.d0,1.75d0)
C      call pllab('Energy (eV)', '','')
      call pllsty(1)
      call plschr(0.d0,2.25d0)
      call pllsty(2)
      call plschr(0.d0, 1.5d0)
      call plssym(0.d0, 1.5d0)
      call plcol0(1)
      do 262 i=1, 2
      read(21,*) xI6(i), Eph6(i)
 262  continue
      do 272 i=1, 2
      read(22,*) xI7(i), Eph7(i)
 272  continue
      call plcol0(9)
      call plwid(1)
      call pllsty(1)
      call plpoin(2, xI6,Eph6,17)
      call plcol0(2)
      call plwid(1)
      call pllsty(1)
      call plssym(0.d0,0.8d0)
      call plpoin(2, xI7,Eph7,16)
      call plssym(0.d0,1.5d0)
      call plschr(0.d0,1.5d0)
      call plcol0(1)
      call plmtex('l',6.0d0, 0.5d0, 0.5d0,
     +  'Theory E#dCLS#u (eV)' )
      call plmtex('r',7.0d0, 0.5d0, 0.5d0,
     +  'Exp. Binding Energies (eV)' )
      call plschr(0.0d0,2.25d0)  

      CLOSE(UNIT=21)
C      Don't forget to call PLEND to finish off!
      call plend()
      end
