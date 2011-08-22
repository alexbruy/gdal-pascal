{
  Demo program for OGR Pascal API.
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

program ogr_drivers;

uses
  gdalcore,
  ogr,
  SysUtils;

var
  driver: OGRSFDriverH;
  driverName: CPChar;
  driversCount, i: longint;

begin
  OGRRegisterAll;

  driversCount := OGRGetDriverCount;
  writeln(driversCount, ' drivers are registered.');

  // iterate over drivers and get their metadata and capabilities
  for i := 0 to driversCount - 1 do begin
    driver := OGRGetDriver (i);
    if driver = Nil then begin
      writeln('Failed to get driver ', i);
      writeln;
      continue;
    end;

    driverName := OGR_Dr_GetName (driver);
    writeln(Format('Driver %2d is %s', [i, string (driverName)]));

    if OGR_Dr_TestCapability(driver, ODrCCreateDataSource) = 1 then begin
      writeln(Format(' %s - yes', [ODrCCreateDataSource]));
    end
    else begin
      writeln(Format(' %s - no', [ODrCCreateDataSource]));
    end;

    if OGR_Dr_TestCapability(driver, ODrCDeleteDataSource) = 1 then begin
      writeln(Format(' %s - yes', [ODrCDeleteDataSource]));
    end
    else begin
      writeln(Format(' %s - no', [ODrCDeleteDataSource]));
    end;

    writeln;
  end;

  OGRCleanupAll;
end.
