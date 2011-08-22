{
  Demo program for OGR Pascal API.
  Read hardcoded shapefile and list all available info about it.
  Also display info about all features.

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

program shape_read;

uses
  gdalcore,
  ogr,
  SysUtils;

const
  { shapefile to open }
  dsName = 'geosample-spatialite-gis.sqlite';
  //dsName = 'admin.shp';
  layerNum = 0;
  layerName = 'admin';

var
  ogrDS: OGRDataSourceH;
  ogrLayer: OGRLayerH;
  extent: OGREnvelope;

  feature: OGRFeatureH;
  featDefn: OGRFeatureDefnH;
  geomType: OGRwkbGeometryType;

  geom: OGRGeometryH;
  wkt: PCPChar;

  fieldDefn: OGRFieldDefnH;
  fieldType: OGRFieldType;
  fieldName, typeName: string;
  fieldWidth, fieldPrec: longint;
  value, msg: string;

  count, err, i, j: longint;

procedure TestCapability(layer: OGRLayerH; cap: PChar);
begin
  if OGR_L_TestCapability(layer, cap) = 1 then begin
    writeln(Format('%s - yes', [cap]));
  end
  else begin
    writeln(Format('%s - no', [cap]));
  end;
end;

begin
  OGRRegisterAll;

  // try to open datasource
  ogrDS := OGROpen(dsName, 0, Nil);
  if ogrDS = Nil then begin
    writeln('Failed to open datasource.');
    exit;
  end;

  // get the number of layers in this data source
  count := OGR_DS_GetLayerCount(ogrDS);
  writeln(Format('There are %2d layer(s) in datasource', [count]));

  // now fetch layer (by name or by number)
  ogrLayer := OGR_DS_GetLayerByName(ogrDS, layerName);
  //ogrLayer := OGR_DS_GetLayer(ogrDS, layerNum);
  if ogrLayer = Nil then begin
    //writeln(Format('Failed to get layer %d', [layerNum]));
    writeln(Format('Failed to get layer %s', [layerName]));
    exit;
  end;

  // test layer capabilities
  writeln('This layer supports following capabilities');
  TestCapability(ogrLayer, OLCRandomRead);
  TestCapability(ogrLayer, OLCSequentialWrite);
  TestCapability(ogrLayer, OLCRandomWrite);
  TestCapability(ogrLayer, OLCFastSpatialFilter);
  TestCapability(ogrLayer, OLCFastFeatureCount);
  TestCapability(ogrLayer, OLCFastGetExtent);
  TestCapability(ogrLayer, OLCCreateField);
  TestCapability(ogrLayer, OLCTransactions);
  TestCapability(ogrLayer, OLCDeleteFeature);
  TestCapability(ogrLayer, OLCFastSetNextByIndex);
  TestCapability(ogrLayer, OLCStringsAsUTF8);
  writeln;

  // fetch layer extent
  err := OGR_L_GetExtent(ogrLayer, extent, 0);
  if err = OGRERR_NONE then begin
    writeln('Layer extent is:');
    writeln(Format(' MinX %10.2f', [extent.MinX]));
    writeln(Format(' MinY %10.2f', [extent.MinY]));
    writeln(Format(' MaxX %10.2f', [extent.MaxX]));
    writeln(Format(' MaxY %10.2f', [extent.MaxY]));
  end
  else begin
    writeln(Format('Error getting layer extent %d', [err]));
  end;

  // fetch feature count
  count := OGR_L_GetFeatureCount(ogrLayer, 0);
  writeln(Format('There are %d feature(s) in the layer', [count]));

  featDefn := OGR_L_GetLayerDefn(ogrLayer);
  // get layer geometry type
  geomType := OGR_FD_GetGeomType(featDefn);
  writeln(Format('Layer geometry type is %d (%s)', [geomType, OGRGeometryTypeToName(geomType)]));
  // get field count
  count := OGR_FD_GetFieldCount(featDefn);
  writeln(Format('There are %d fileds in the layer shema', [count]));

  // fetch details about each field in shema
  writeln('Num |    Name    | Type |  TypeName  | Width | Precision ');
  for i := 0 to count - 1 do begin
    fieldDefn := OGR_FD_GetFieldDefn(featDefn, i);

    fieldName := string(OGR_Fld_GetNameRef(fieldDefn));
    fieldType := OGR_Fld_GetType(fieldDefn);
    typeName := string(OGR_GetFieldTypeName(fieldType));
    fieldWidth := OGR_Fld_GetWidth(fieldDefn);
    fieldPrec := OGR_Fld_GetPrecision(fieldDefn);
    msg := Format('%4d|%12s|%6d|%12s|%7d|%11d', [i + 1, fieldName, fieldType, typeName, fieldWidth, fieldPrec]);
    writeln(msg);
  end;

  // it is safe to reset read position on the first feature
  OGR_L_ResetReading(ogrLayer);
  // fetch first feature
  feature := OGR_L_GetNextFeature(ogrLayer);
  j := 0;
  // iterate over all features in layer, print their fields values and geometry
  while feature <> Nil do begin
    Inc(j);
    writeln(Format('Feature %d', [j]));
    writeln('------------');
    for i := 0 to count - 1 do begin
      fieldDefn := OGR_FD_GetFieldDefn(featDefn, i);
      fieldName := string(OGR_Fld_GetNameRef(fieldDefn));
      value := string(OGR_F_GetFieldAsString(feature, i));
      writeln(Format('%s: %s', [fieldName, value]));
    end;

    // fetch feature geometry in WKT format
    geom := OGR_F_GetGeometryRef(feature);
    //err := OGR_G_ExportToWkt(geom, wkt);
    //if err = OGRERR_NONE then begin
    //  writeln('Error fetching geometry');
    //end;
    //value := string(@wkt);
    //writeln(Format('WKT geometry: %s', [value]));

    writeln;
    feature := OGR_L_GetNextFeature(ogrLayer);
  end;

  err := OGRReleaseDatasource(ogrDS);
  if err <> OGRERR_NONE then begin
    writeln(Format('Error releasing datasource: %d', [err]));
  end;

  OGRCleanupAll;
end.
