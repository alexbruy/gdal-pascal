{
  Demo program for GDAL Pascal API.
  Lists all supported drivers and their capabilities.

  Copyright (C) 2010 Alexander Bruy (alexander.bruy@gmail.com)

  This source is free software; you can redistribute it and/or modify it under
  the terms of the GNU General Public License as published by the Free
  Software Foundation; either version 2 of the License, or (at your option)
  any later version.

  This code is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

  A copy of the GNU General Public License is available on the World Wide Web
  at <http://www.gnu.org/copyleft/gpl.html>. You can also obtain it by writing
  to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
  MA 02111-1307, USA.
}

{$H+}

{$IFDEF FPC}
  {$MODE objfpc}
{$ENDIF}

program gdal_drivers;

uses
  gdalcore,
  gdal,
  SysUtils;

var
  driver: GDALDriverH;
  driverShortName, driverLongName: CPChar;
  driverOptions, driverHelp: CPChar;
  driversCount, i: longint;

begin
  //GDALAllRegister;

  driversCount := GDALGetDriverCount;
  writeln(driversCount, ' drivers are registered.');

  // iterate over drivers and get their metadata and capabilities
  for i := 0 to driversCount - 1 do begin
    driver := GDALGetDriver (i);
    if driver = Nil then begin
      writeln('Failed to get driver ', i);
      writeln;
      continue;
    end;

    driverShortName := GDALGetDriverShortName (driver);
    driverLongName := GDALGetDriverLongName (driver);
    driverOptions := GDALGetDriverCreationOptionList (driver);
    driverHelp := GDALGetDriverHelpTopic (driver);

    writeln(Format('Driver %2d short name is %s', [i, string (driverShortName)]));
    writeln(Format('Driver %2d long name is %s', [i, string (driverLongName)]));
    writeln(Format('Driver %2d help URL is %s', [i, string (driverHelp)]));
    writeln(Format('Driver %2d options are %s', [i, string (driverOptions)]));

    writeln;
  end;

end.
