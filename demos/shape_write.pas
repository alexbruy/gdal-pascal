{
  Demo program for OGR Pascal API.
  Write point shapefile.

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

program shape_write;

uses
  gdalcore,
  ogr,
  SysUtils;

const
  { shapefile to write }
  dsName = 'test.shp';
  layerNum = 0;
  layerName = 'test';
  driverName = 'ESRI Shapefile';

var
  ogrDriver: OGRSFDriverH;
  ogrDS: OGRDataSourceH;
  ogrLayer: OGRLayerH;
  geomType: OGRwkbGeometryType;

  fieldDefn: OGRFieldDefnH;

  feature: OGRFeatureH;
  featDefn: OGRFeatureDefnH;

  geom: OGRGeometryH;

  err: longint;

begin
  OGRRegisterAll;
  
  // try to init driver
  ogrDriver := OGRGetDriverByName(PChar(driverName));
  if ogrDriver = Nil then begin
    writeln(Format('%s driver not available.', [driverName]));
    exit;
  end;

  // then try to create datasource
  ogrDS := OGR_Dr_CreateDataSource(ogrDriver, dsName, Nil);
  if ogrDS = Nil then begin
    writeln(Format('Failed to create output file %s.', [dsName]));
    exit;
  end;

  // now try to create point layer inside datasource
  ogrLayer := OGR_DS_CreateLayer(ogrDS, layerName, Nil, wkbPoint, Nil);
  if ogrLayer = Nil then begin
    writeln(Format('Failed to create layer %s in datasource.', [layerName]));
    exit;
  end;

  // create new field in the layer
  fieldDefn := OGR_Fld_Create('Name', OFTString);
  OGR_Fld_SetWidth(fieldDefn, 10);
  err := OGR_L_CreateField(ogrLayer, fieldDefn, 1);
  if err <> OGRERR_NONE then begin
    writeln('Failed to create field.');
    exit;
  end;

  // create new feature and fill attributes (fields)
  featDefn := OGR_L_GetLayerDefn(ogrLayer);
  feature := OGR_F_Create(featDefn);
  OGR_F_SetFieldString(feature, 0, 'first');

  // create geometry and add it to the feature
  geom := OGR_G_CreateGeometry(wkbPoint);
  OGR_G_SetPoint_2D(geom, 0, 100, 100);
  err := OGR_F_SetGeometry(feature, geom);
  if err <> OGRERR_NONE then begin
    writeln('Failed to set geometry to the feature.');
    exit;
  end;

  // write feature to the layer
  err := OGR_L_CreateFeature(ogrLayer, feature);
  if err <> OGRERR_NONE then begin
    writeln('Failed to write feature in layer.');
    exit;
  end;

  OGR_F_Destroy(feature);

  err := OGRReleaseDatasource(ogrDS);
  if err <> OGRERR_NONE then begin
    writeln(Format('Error releasing datasource: %d', [err]));
  end;

  OGRCleanupAll;
end.
