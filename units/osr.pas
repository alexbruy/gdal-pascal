{
  Delphi API and constant declarations for OGR Spatial References

  Copyright (C) 2010 Alexander Bruy (alexander.bruy@gmail.com)

  Based on the sources automatically converted by H2Pas 1.0.0
  The original files are: ogr_srs_api.h

  Permission is hereby granted, free of charge, to any person obtaining a
  copy of this software and associated documentation files (the "Software"),
  to deal in the Software without restriction, including without limitation
  the rights to use, copy, modify, merge, publish, distribute, sublicense,
  and/or sell copies of the Software, and to permit persons to whom the
  Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included
  in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  DEALINGS IN THE SOFTWARE.
}

{******************************************************************************
 * $Id: ogr_srs_api.h 17970 2009-11-06 20:00:29Z warmerdam $
 *
 * Project:  OpenGIS Simple Features Reference Implementation
 * Purpose:  C API and constant declarations for OGR Spatial References.
 * Author:   Frank Warmerdam, warmerdam@pobox.com
 *
 ******************************************************************************
 * Copyright (c) 2000, Frank Warmerdam
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the 'Software'),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 ****************************************************************************}

{$H+}

{$IFDEF FPC}
  {$MODE objfpc}
  {$PACKRECORDS C}
{$ENDIF}

unit ogr;

interface

uses
  gdalcore,
  ogr;

//----------------------------------------------------------------------------

const
  { Some standard WKT geographic coordinate systems }
  SRS_WKT_WGS84 = 'GEOGCS[\"WGS 84\",DATUM[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,AUTHORITY[\"EPSG\",\"7030\"]],TOWGS84[0,0,0,0,0,0,0],AUTHORITY[\"EPSG\",\"6326\"]],PRIMEM[\"Greenwich\",0,AUTHORITY[\"EPSG\",\"8901\"]],UNIT[\"degree\",0.0174532925199433,AUTHORITY[\"EPSG\",\"9108\"]],AUTHORITY[\"EPSG\",\"4326\"]]'

  { Some 'standard' strings }
  SRS_PT_ALBERS_CONIC_EQUAL_AREA =
                            'Albers_Conic_Equal_Area';
  SRS_PT_AZIMUTHAL_EQUIDISTANT   =
                            'Azimuthal_Equidistant';
  SRS_PT_CASSINI_SOLDNER         =
                            'Cassini_Soldner';
  SRS_PT_CYLINDRICAL_EQUAL_AREA  =
                            'Cylindrical_Equal_Area';
  SRS_PT_BONNE           =  'Bonne';
  SRS_PT_ECKERT_I        =  'Eckert_I';
  SRS_PT_ECKERT_II       =  'Eckert_II';
  SRS_PT_ECKERT_III      =  'Eckert_III';
  SRS_PT_ECKERT_IV       =  'Eckert_IV';
  SRS_PT_ECKERT_V        =  'Eckert_V';
  SRS_PT_ECKERT_VI       =  'Eckert_VI';
  SRS_PT_EQUIDISTANT_CONIC =
                            'Equidistant_Conic';
  SRS_PT_EQUIRECTANGULAR   =
                            'Equirectangular';
  SRS_PT_GALL_STEREOGRAPHIC =
                            'Gall_Stereographic';
  SRS_PT_GAUSSSCHREIBERTMERCATOR =
                            'Gauss_Schreiber_Transverse_Mercator';
  SRS_PT_GEOSTATIONARY_SATELLITE =
                            'Geostationary_Satellite';
  SRS_PT_GOODE_HOMOLOSINE = 'Goode_Homolosine';
  SRS_PT_GNOMONIC         = 'Gnomonic';
  SRS_PT_HOTINE_OBLIQUE_MERCATOR =
                            'Hotine_Oblique_Mercator';
  SRS_PT_HOTINE_OBLIQUE_MERCATOR_TWO_POINT_NATURAL_ORIGIN =
                            'Hotine_Oblique_Mercator_Two_Point_Natural_Origin';
  SRS_PT_LABORDE_OBLIQUE_MERCATOR    =
                            'Laborde_Oblique_Mercator';
  SRS_PT_LAMBERT_CONFORMAL_CONIC_1SP =
                            'Lambert_Conformal_Conic_1SP';
  SRS_PT_LAMBERT_CONFORMAL_CONIC_2SP =
                            'Lambert_Conformal_Conic_2SP';
  SRS_PT_LAMBERT_CONFORMAL_CONIC_2SP_BELGIUM =
                            'Lambert_Conformal_Conic_2SP_Belgium';
  SRS_PT_LAMBERT_AZIMUTHAL_EQUAL_AREA =
                            'Lambert_Azimuthal_Equal_Area';
  SRS_PT_MERCATOR_1SP    =  'Mercator_1SP';
  SRS_PT_MERCATOR_2SP    =  'Mercator_2SP';
  SRS_PT_MILLER_CYLINDRICAL =
                            'Miller_Cylindrical';
  SRS_PT_MOLLWEIDE       =  'Mollweide';
  SRS_PT_NEW_ZEALAND_MAP_GRID =
                            'New_Zealand_Map_Grid';
  SRS_PT_OBLIQUE_STEREOGRAPHIC =
                            'Oblique_Stereographic';
  SRS_PT_ORTHOGRAPHIC    =  'Orthographic';
  SRS_PT_POLAR_STEREOGRAPHIC =
                            'Polar_Stereographic';
  SRS_PT_POLYCONIC       =  'Polyconic';
  SRS_PT_ROBINSON        =  'Robinson';
  SRS_PT_SINUSOIDAL      =  'Sinusoidal';
  SRS_PT_STEREOGRAPHIC   =  'Stereographic';
  SRS_PT_SWISS_OBLIQUE_CYLINDRICAL =
                            'Swiss_Oblique_Cylindrical';
  SRS_PT_TRANSVERSE_MERCATOR =
                            'Transverse_Mercator';
  SRS_PT_TRANSVERSE_MERCATOR_SOUTH_ORIENTED =
                            'Transverse_Mercator_South_Orientated';

  { special mapinfo variants on Transverse Mercator }
  SRS_PT_TRANSVERSE_MERCATOR_MI_21 = 'Transverse_Mercator_MapInfo_21';
  SRS_PT_TRANSVERSE_MERCATOR_MI_22 = 'Transverse_Mercator_MapInfo_22';
  SRS_PT_TRANSVERSE_MERCATOR_MI_23 = 'Transverse_Mercator_MapInfo_23';
  SRS_PT_TRANSVERSE_MERCATOR_MI_24 = 'Transverse_Mercator_MapInfo_24';
  SRS_PT_TRANSVERSE_MERCATOR_MI_25 = 'Transverse_Mercator_MapInfo_25';

  SRS_PT_TUNISIA_MINING_GRID   =
                           'Tunisia_Mining_Grid';
  SRS_PT_TWO_POINT_EQUIDISTANT =
                           'Two_Point_Equidistant';
  SRS_PT_VANDERGRINTEN   = 'VanDerGrinten';
  SRS_PT_KROVAK          = 'Krovak';
  SRS_PT_IMW_POLYCONIC   = 'International_Map_of_the_World_Polyconic';
  SRS_PT_WAGNER_I        = 'Wagner_I';
  SRS_PT_WAGNER_II       = 'Wagner_II';
  SRS_PT_WAGNER_III      = 'Wagner_III';
  SRS_PT_WAGNER_IV       = 'Wagner_IV';
  SRS_PT_WAGNER_V        = 'Wagner_V';
  SRS_PT_WAGNER_VI       = 'Wagner_VI';
  SRS_PT_WAGNER_VII      = 'Wagner_VII';

  SRS_PP_CENTRAL_MERIDIAN         = 'central_meridian';
  SRS_PP_SCALE_FACTOR             = 'scale_factor';
  SRS_PP_STANDARD_PARALLEL_1      = 'standard_parallel_1';
  SRS_PP_STANDARD_PARALLEL_2      = 'standard_parallel_2';
  SRS_PP_PSEUDO_STD_PARALLEL_1    = 'pseudo_standard_parallel_1';
  SRS_PP_LONGITUDE_OF_CENTER      = 'longitude_of_center';
  SRS_PP_LATITUDE_OF_CENTER       = 'latitude_of_center';
  SRS_PP_LONGITUDE_OF_ORIGIN      = 'longitude_of_origin';
  SRS_PP_LATITUDE_OF_ORIGIN       = 'latitude_of_origin';
  SRS_PP_FALSE_EASTING            = 'false_easting';
  SRS_PP_FALSE_NORTHING           = 'false_northing';
  SRS_PP_AZIMUTH                  = 'azimuth';
  SRS_PP_LONGITUDE_OF_POINT_1     = 'longitude_of_point_1';
  SRS_PP_LATITUDE_OF_POINT_1      = 'latitude_of_point_1';
  SRS_PP_LONGITUDE_OF_POINT_2     = 'longitude_of_point_2';
  SRS_PP_LATITUDE_OF_POINT_2      = 'latitude_of_point_2';
  SRS_PP_LONGITUDE_OF_POINT_3     = 'longitude_of_point_3';
  SRS_PP_LATITUDE_OF_POINT_3      = 'latitude_of_point_3';
  SRS_PP_RECTIFIED_GRID_ANGLE     = 'rectified_grid_angle';
  SRS_PP_LANDSAT_NUMBER           = 'landsat_number';
  SRS_PP_PATH_NUMBER              = 'path_number';
  SRS_PP_PERSPECTIVE_POINT_HEIGHT = 'perspective_point_height';
  SRS_PP_SATELLITE_HEIGHT         = 'satellite_height';
  SRS_PP_FIPSZONE                 = 'fipszone';
  SRS_PP_ZONE                     = 'zone';
  SRS_PP_LATITUDE_OF_1ST_POINT    = 'Latitude_Of_1st_Point';
  SRS_PP_LONGITUDE_OF_1ST_POINT   = 'Longitude_Of_1st_Point';
  SRS_PP_LATITUDE_OF_2ND_POINT    = 'Latitude_Of_2nd_Point';
  SRS_PP_LONGITUDE_OF_2ND_POINT   = 'Longitude_Of_2nd_Point';

  SRS_UL_METER              = 'Meter';
  SRS_UL_FOOT               = 'Foot (International)'; { or just 'FOOT'? }
  SRS_UL_FOOT_CONV          = '0.3048';
  SRS_UL_US_FOOT            = 'Foot_US'; { or 'US survey foot' from EPSG }
  SRS_UL_US_FOOT_CONV       = '0.3048006096012192';
  SRS_UL_NAUTICAL_MILE      = 'Nautical Mile';
  SRS_UL_NAUTICAL_MILE_CONV = '1852.0';
  SRS_UL_LINK               = 'Link';          { Based on US Foot }
  SRS_UL_LINK_CONV          = '0.20116684023368047';
  SRS_UL_CHAIN              = 'Chain';         { based on US Foot }
  SRS_UL_CHAIN_CONV         = '20.116684023368047';
  SRS_UL_ROD                = 'Rod';           { based on US Foot }
  SRS_UL_ROD_CONV           = '5.02921005842012';

  SRS_UA_DEGREE          = 'degree';
  SRS_UA_DEGREE_CONV     = '0.0174532925199433';
  SRS_UA_RADIAN          = 'radian';

  SRS_PM_GREENWICH       = 'Greenwich';

  SRS_DN_NAD27           = 'North_American_Datum_1927';
  SRS_DN_NAD83           = 'North_American_Datum_1983';
  SRS_DN_WGS72           = 'WGS_1972';
  SRS_DN_WGS84           = 'WGS_1984';

  SRS_WGS84_SEMIMAJOR     = 6378137.0;
  SRS_WGS84_INVFLATTENING = 298.257223563;

//----------------------------------------------------------------------------

type
  { Axis orientations (corresponds to CS_AxisOrientationEnum) }
  OGRAxisOrientation =
  (
    OAO_Other = 0,
    OAO_North = 1,
    OAO_South = 2,
    OAO_East  = 3,
    OAO_West  = 4,
    OAO_Up    = 5,
    OAO_Down  = 6
  );

  { Datum types (corresponds to CS_DatumType) }
  OGRDatumType =
  (
    ODT_HD_Min                = 1000,
    ODT_HD_Other              = 1000,
    ODT_HD_Classic            = 1001,
    ODT_HD_Geocentric         = 1002,
    ODT_HD_Max                = 1999,
    ODT_VD_Min                = 2000,
    ODT_VD_Other              = 2000,
    ODT_VD_Orthometric        = 2001,
    ODT_VD_Ellipsoidal        = 2002,
    ODT_VD_AltitudeBarometric = 2003,
    ODT_VD_Normal             = 2004,
    ODT_VD_GeoidModelDerived  = 2005,
    ODT_VD_Depth              = 2006,
    ODT_VD_Max                = 2999,
    ODT_LD_Min                = 10000,
    ODT_LD_Max                = 32767
  );

  OGRSpatialReferenceH = Pointer;
  OGRCoordinateTransformationH = Pointer;

//----------------------------------------------------------------------------

{ Return the string representation for the OGRAxisOrientation enumeration }
function OSRAxisEnumToName(eOrientation: OGRAxisOrientation): CPChar;
          cdecl; external LibName;

{ Wrappers for C++ objects and methods }

{ Constructor }
function OSRNewSpatialReference(pszWKT: CPChar): OGRSpatialReferenceH;
          cdecl; external LibName;

{ Make a duplicate of the GEOGCS node of this OGRSpatialReference object }
function OSRCloneGeogCS(hSource: OGRSpatialReferenceH): OGRSpatialReferenceH;
          cdecl; external LibName;

{ Make a duplicate of this OGRSpatialReference }
function OSRClone(hSRS: OGRSpatialReferenceH): OGRSpatialReferenceH;
          cdecl; external LibName;

{ OGRSpatialReference destructor }
procedure OSRDestroySpatialReference(hSRS: OGRSpatialReferenceH);
           cdecl; external LibName;


{ Increments the reference count by one }
function OSRReference(hSRS: OGRSpatialReferenceH): longint;
          cdecl; external LibName;

{ Decrements the reference count by one }
function OSRDereference(hSRS: OGRSpatialReferenceH): longint;
          cdecl; external LibName;

{ Decrements the reference count by one, and destroy if zero }
procedure OSRRelease(hSRS: OGRSpatialReferenceH); cdecl; external LibName;


{ Validate SRS tokens }
function OSRValidate(hSRS: OGRSpatialReferenceH): OGRErr;
          cdecl; external LibName;

{ Correct parameter ordering to match CT Specification }
function OSRFixupOrdering(hSRS: OGRSpatialReferenceH): OGRErr;
          cdecl; external LibName;

{ Fixup as needed }
function OSRFixup(hSRS: OGRSpatialReferenceH): OGRErr;
          cdecl; external LibName;

{ Strip OGC CT Parameters }
function OSRStripCTParms(hSRS: OGRSpatialReferenceH): OGRErr;
          cdecl; external LibName;


{ Initialize SRS based on EPSG GCS or PCS code }
function OSRImportFromEPSG(hSRS: OGRSpatialReferenceH;
          nCode: longint): OGRErr; cdecl; external LibName;

{ Initialize SRS based on EPSG GCS or PCS code }
function OSRImportFromEPSGA(hSRS: OGRSpatialReferenceH;
          nCode: longint): OGRErr; cdecl; external LibName;

{ Import from WKT string }
function OSRImportFromWkt(hSRS: OGRSpatialReferenceH;
          ppszInput: PCPСhar): OGRErr; cdecl; external LibName;

{ Import PROJ.4 coordinate string }
function OSRImportFromProj4(hSRS: OGRSpatialReferenceH;
          pszProj4: CPСhar): OGRErr; cdecl; external LibName;

{ Import coordinate system from ESRI .prj format(s) }
function OSRImportFromESRI(hSRS: OGRSpatialReferenceH;
          papszPrj: PCPСhar): OGRErr; cdecl; external LibName;

{ Import coordinate system from PCI projection definition }
function OSRImportFromPCI(hSRS: OGRSpatialReferenceH;
          pszProj: CPСhar; pszUnits: CPСhar; padfPrjParams: Pdouble): OGRErr;
          cdecl; external LibName;

{ Import coordinate system from USGS projection definition }
function OSRImportFromUSGS(hSRS: OGRSpatialReferenceH; iProjsys: longint;
          iZone: longint; padfPrjParams: Pdouble; iDatum: longint): OGRErr;
          cdecl; external LibName;

{ Import coordinate system from XML format (GML only currently) }
function OSRImportFromXML(hSRS: OGRSpatialReferenceH; pszXML: PСhar): OGRErr;
          cdecl; external LibName;

//function OSRImportFromDict(hSRS: OGRSpatialReferenceH; _para2: CPChar; _para3: CPChar): OGRErr;
//function OSRImportFromPanorama(hSRS: OGRSpatialReferenceH; _para2: longint; _para3: longint; _para4: longint; _para5: Pdouble): OGRErr;
//function OSRImportFromOzi(hSRS: OGRSpatialReferenceH; _para2: CPChar; _para3: CPChar; _para4: CPChar): OGRErr;

{ Import Mapinfo style CoordSys definition }
function OSRImportFromMICoordSys(hSRS: OGRSpatialReferenceH;
          pszCoordSys: CPСhar): OGRErr; cdecl; external LibName;

{ Set spatial reference from a URL }
function OSRImportFromUrl(hSRS: OGRSpatialReferenceH; pszUrl: CPСhar): OGRErr;
          cdecl; external LibName;


{ Convert this SRS into WKT format }
function OSRExportToWkt(hSRS: OGRSpatialReferenceH;
          ppszReturn: PCPСhar): OGRErr; cdecl; external LibName;

{ Convert this SRS into a a nicely formatted WKT string for display to
  a person
}
function OSRExportToPrettyWkt(hSRS: OGRSpatialReferenceH; ppszReturn: PCPChar;
          bSimplify: longint): OGRErr; cdecl; external LibName;

{ Export coordinate system in PROJ.4 format }
function OSRExportToProj4(hSRS: OGRSpatialReferenceH;
          ppszReturn: PCPChar): OGRErr; cdecl; external LibName;

{ Export coordinate system in PCI projection definition }
function OSRExportToPCI(hSRS: OGRSpatialReferenceH; ppszProj: PCPChar;
          ppszUnits: PCPChar; ppadfPrjParams: PPdouble): OGRErr;
          cdecl; external LibName;

{ Export coordinate system in USGS GCTP projection definition }
function OSRExportToUSGS(hSRS: OGRSpatialReferenceH; piProjSys: Plongint;
          piZone: Plongint; ppadfPrjParams: PPdouble;
          piDatum: Plongint): OGRErr; cdecl; external LibName;

{ Export coordinate system in XML format }
function OSRExportToXML(hSRS: OGRSpatialReferenceH; ppszRawXML: PPChar;
          pszDialect: PChar): OGRErr; cdecl; external LibName;

//function OSRExportToPanorama(hSRS: OGRSpatialReferenceH; _para2: Plongint; _para3: Plongint; _para4: Plongint; _para5: Plongint; _para6: Pdouble): OGRErr;

{ Export coordinate system in Mapinfo style CoordSys format }
function OSRExportToMICoordSys(hSRS: OGRSpatialReferenceH;
          ppszReturn: PCPChar): OGRErr; cdecl; external LibName;


{ Convert in place to ESRI WKT format }
function OSRMorphToESRI(hSRS: OGRSpatialReferenceH): OGRErr;
          cdecl; external LibName;

{ Convert in place from ESRI WKT format }
function OSRMorphFromESRI(hSRS: OGRSpatialReferenceH): OGRErr;
          cdecl; external LibName;


{ Set attribute value in spatial reference }
function OSRSetAttrValue(hSRS: OGRSpatialReferenceH; pszPath: CPChar;
          pszValue: CPChar): OGRErr; cdecl; external LibName;

{ Fetch indicated attribute of named node }
function OSRGetAttrValue(hSRS: OGRSpatialReferenceH; pszKey: CPChar;
          iChild: longint): CPChar; cdecl; external LibName;


{ Set the angular units for the geographic coordinate system }
function OSRSetAngularUnits(hSRS: OGRSpatialReferenceH; pszUnits: CPChar;
          dfInRadians: double): OGRErr; cdecl; external LibName;

{ Fetch angular geographic coordinate system units }
function OSRGetAngularUnits(hSRS: OGRSpatialReferenceH;
          ppszName: PPChar): double; cdecl; external LibName;

{ Set the linear units for the projection }
function OSRSetLinearUnits(hSRS: OGRSpatialReferenceH; pszUnits: CPChar;
          dfInMeters: double): OGRErr; cdecl; external LibName;

{ Set the linear units for the projection }
function OSRSetLinearUnitsAndUpdateParameters(hSRS: OGRSpatialReferenceH;
          pszUnits: CPChar; dfInMeters: double): OGRErr;
          cdecl; external LibName;

{ Fetch linear projection units }
function OSRGetLinearUnits(hSRS: OGRSpatialReferenceH;
          ppszName: PCPChar): double; cdecl; external LibName;


{ Fetch prime meridian info }
function OSRGetPrimeMeridian(hSRS: OGRSpatialReferenceH;
          ppszName: PPChar): double; cdecl; external LibName;


{ Check if geographic coordinate system }
function OSRIsGeographic(hSRS: OGRSpatialReferenceH): longint;
          cdecl; external LibName;

{ Check if local coordinate system }
function OSRIsLocal(hSRS: OGRSpatialReferenceH): longint;
          cdecl; external LibName;

{ Check if projected coordinate system }
function OSRIsProjected(hSRS: OGRSpatialReferenceH): longint;
          cdecl; external LibName;

{ Do the GeogCS'es match? }
function OSRIsSameGeogCS(hSRS1: OGRSpatialReferenceH;
          hSRS2: OGRSpatialReferenceH): longint; cdecl; external LibName;

{ Do these two spatial references describe the same system?  }
function OSRIsSame(hSRS1: OGRSpatialReferenceH;
          hSRS2: OGRSpatialReferenceH): longint; cdecl; external LibName;


{ Set the user visible LOCAL_CS name }
function OSRSetLocalCS(hSRS: OGRSpatialReferenceH; pszName: CPChar): OGRErr;
          cdecl; external LibName;

{ Set the user visible PROJCS name }
function OSRSetProjCS(hSRS: OGRSpatialReferenceH; pszName: CPChar): OGRErr;
          cdecl; external LibName;

{ Set a GeogCS based on well known name }
function OSRSetWellKnownGeogCS(hSRS: OGRSpatialReferenceH;
          pszName: CPChar): OGRErr; cdecl; external LibName;

{ Set spatial reference from various text formats }
function OSRSetFromUserInput(hSRS: OGRSpatialReferenceH;
          pszDef: CPChar): OGRErr; cdecl; external LibName;

{ Copy GEOGCS from another OGRSpatialReference }
function OSRCopyGeogCSFrom(hSRS: OGRSpatialReferenceH;
          hSrcSRS: OGRSpatialReferenceH): OGRErr; cdecl; external LibName;

{ Set the Bursa-Wolf conversion to WGS84 }
function OSRSetTOWGS84(hSRS: OGRSpatialReferenceH; dfDX: double;
          dfDY: double; dfDZ: double; dfEX: double; dfEY: double;
          dfEZ: double; dfPPM: double): OGRErr; cdecl; external LibName;

{ Fetch TOWGS84 parameters, if available }
function OSRGetTOWGS84(hSRS: OGRSpatialReferenceH; padfCoeff: Pdouble;
          nCoeffCount: longint): OGRErr; cdecl; external LibName;


{ Set geographic coordinate system }
function OSRSetGeogCS(hSRS: OGRSpatialReferenceH; pszGeogName: CPChar;
          pszDatumName: CPChar; pszSpheroidName: CPChar; dfSemiMajor: double;
          dfInvFlattening: double; pszPMName: CPChar; dfPMOffset: double;
          pszAngularUnits: CPChar; dfConvertToRadians: double): OGRErr;
          cdecl; external LibName;


{ Get spheroid semi major axis }
function OSRGetSemiMajor(hSRS: OGRSpatialReferenceH; pnErr: POGRErr): double;
          cdecl; external LibName;

{ Get spheroid semi minor axis }
function OSRGetSemiMinor(hSRS: OGRSpatialReferenceH; pnErr: POGRErr): double;
          cdecl; external LibName;

{ Get spheroid inverse flattening }
function OSRGetInvFlattening(hSRS: OGRSpatialReferenceH; pnErr: POGRErr): double;
          cdecl; external LibName;


{ Set the authority for a node }
function OSRSetAuthority(hSRS: OGRSpatialReferenceH; pszTargetKey: CPChar;
          pszAuthority: CPChar; nCode: longint): OGRErr;
          cdecl; external LibName;

{ Get the authority code for a node }
function OSRGetAuthorityCode(hSRS: OGRSpatialReferenceH;
          pszTargetKey: CPChar): CPChar; cdecl; external LibName;

{ Get the authority name for a node }
function OSRGetAuthorityName(hSRS: OGRSpatialReferenceH;
          pszTargetKey: CPChar): CPChar; cdecl; external LibName;

{ Set a projection name }
function OSRSetProjection(hSRS: OGRSpatialReferenceH;
          pszProjection: CPChar): OGRErr; cdecl; external LibName;

{ Set a projection parameter value }
function OSRSetProjParm(hSRS: OGRSpatialReferenceH; pszParmName: CPChar;
          dfValue: double): OGRErr; cdecl; external LibName;

{ Fetch a projection parameter value }
function OSRGetProjParm(hSRS: OGRSpatialReferenceH; pszName: CPChar;
          dfDefaultValue: double; pnErr: POGRErr): double;
          cdecl; external LibName;

{ Set a projection parameter with a normalized value }
function OSRSetNormProjParm(hSRS: OGRSpatialReferenceH; pszParmName: CPChar;
          dfValue: double): OGRErr; cdecl; external LibName;

{  }
function OSRGetNormProjParm(hSRS: OGRSpatialReferenceH; pszName: CPChar;
          dfDefaultValue: double; pnErr: POGRErr): double;
          cdecl; external LibName;


{ Set UTM projection definition }
function OSRSetUTM(hSRS: OGRSpatialReferenceH; nZone: longint;
          bNorth: longint): OGRErr; cdecl; external LibName;

{ Get UTM zone information }
function OSRGetUTMZone(hSRS: OGRSpatialReferenceH; pbNorth: plongint): longint;
          cdecl; external LibName;

//function OSRSetStatePlane(hSRS: OGRSpatialReferenceH; nZone: longint; bNAD83: longint): OGRErr;
//function OSRSetStatePlaneWithUnits(hSRS: OGRSpatialReferenceH; nZone: longint; bNAD83: longint; pszOverrideUnitName: CPChar; dfOverrideUnit: double): OGRErr;
//function OSRAutoIdentifyEPSG(hSRS: OGRSpatialReferenceH): OGRErr;


//function OSREPSGTreatsAsLatLong(hSRS: OGRSpatialReferenceH): longint;

{ Fetch the orientation of one axis }
function OSRGetAxis(hSRS: OGRSpatialReferenceH; pszTargetKey: CPChar;
          iAxis: longint; peOrientation: pOGRAxisOrientation): CPChar;
          cdecl; external LibName;

//function OSRSetAxes(pszTargetKey: CPChar; pszXAxisName: CPChar; eXAxisOrientation: OGRAxisOrientation; pszYAxisName: CPChar; eYAxisOrientation: OGRAxisOrientation): OGRErr;


{ Albers Conic Equal Area }
function OSRSetACEA(hSRS: OGRSpatialReferenceH; dfStdP1: double;
          dfStdP2: double; dfCenterLat: double; dfCenterLong: double;
          dfFalseEasting: double; dfFalseNorthing: double): OGRErr;
          cdecl; external LibName;

{ Azimuthal Equidistant }
function OSRSetAE(hSRS: OGRSpatialReferenceH; dfCenterLat: double;
          dfCenterLong: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Bonne }
function OSRSetBonne(hSRS: OGRSpatialReferenceH; dfStandardParallel: double;
          dfCentralMeridian: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Cylindrical Equal Area }
function OSRSetCEA(hSRS: OGRSpatialReferenceH; dfStdP1: double;
          dfCentralMeridian: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Cassini-Soldner }
function OSRSetCS(hSRS: OGRSpatialReferenceH; dfCenterLat: double;
          dfCenterLong: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Equidistant Conic }
function OSRSetEC(hSRS: OGRSpatialReferenceH; dfStdP1: double; dfStdP2: double;
          dfCenterLat: double; dfCenterLong: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Eckert I-VI }
function OSRSetEckert(hSRS: OGRSpatialReferenceH; nVariation: longint;
          dfCentralMeridian: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Eckert IV }
function OSRSetEckertIV(hSRS: OGRSpatialReferenceH; dfCentralMeridian: double;
          dfFalseEasting: double; dfFalseNorthing: double): OGRErr;
          cdecl; external LibName;

{ Eckert VI }
function OSRSetEckertVI(hSRS: OGRSpatialReferenceH; dfCentralMeridian: double;
          dfFalseEasting: double; dfFalseNorthing: double): OGRErr;
          cdecl; external LibName;

{ Equirectangular }
function OSRSetEquirectangular(hSRS: OGRSpatialReferenceH; dfCenterLat: double;
          dfCenterLong: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Equirectangular generalized form }
function OSRSetEquirectangular2(hSRS: OGRSpatialReferenceH;
          dfCenterLat: double; dfCenterLong: double;
          dfPseudoStdParallel1: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Gall Stereograpic }
function OSRSetGS(hSRS: OGRSpatialReferenceH; dfCentralMeridian: double;
          dfFalseEasting: double; dfFalseNorthing: double): OGRErr;
          cdecl; external LibName;

{ Goode Homolosine }
function OSRSetGH(hSRS: OGRSpatialReferenceH; dfCentralMeridian: double;
          dfFalseEasting: double; dfFalseNorthing: double): OGRErr;
          cdecl; external LibName;

{ GEOS - Geostationary Satellite View }
function OSRSetGEOS(hSRS: OGRSpatialReferenceH; dfCentralMeridian: double;
          dfSatelliteHeight: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Gauss Schreiber Transverse Mercator }
function OSRSetGaussSchreiberTMercator(hSRS: OGRSpatialReferenceH;
          dfCenterLat: double; dfCenterLong: double; dfScale: double;
          dfFalseEasting: double; dfFalseNorthing: double): OGRErr;

{ Gnomonic }
function OSRSetGnomonic(hSRS: OGRSpatialReferenceH; dfCenterLat: double;
          dfCenterLong: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Hotine Oblique Mercator using azimuth angle }
function OSRSetHOM(hSRS: OGRSpatialReferenceH; dfCenterLat: double;
          dfCenterLong: double; dfAzimuth: double; dfRectToSkew: double;
          dfScale: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Hotine Oblique Mercator using two points on centerline }
function OSRSetHOM2PNO(hSRS: OGRSpatialReferenceH; dfCenterLat: double;
          dfLat1: double; dfLong1: double; dfLat2: double; dfLong2: double;
          dfScale: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ International Map of the World Polyconic }
function OSRSetIWMPolyconic(hSRS: OGRSpatialReferenceH; dfLat1: double;
          dfLat2: double; dfCenterLong: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr;

{ Krovak Oblique Conic Conformal }
function OSRSetKrovak(hSRS: OGRSpatialReferenceH; dfCenterLat: double;
          dfCenterLong: double; dfAzimuth: double;
          dfPseudoStdParallelLat: double; dfScale: double;
          dfFalseEasting: double; dfFalseNorthing: double): OGRErr;
          cdecl; external LibName;

{ Lambert Azimuthal Equal-Area }
function OSRSetLAEA(hSRS: OGRSpatialReferenceH; dfCenterLat: double;
          dfCenterLong: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Lambert Conformal Conic }
function OSRSetLCC(hSRS: OGRSpatialReferenceH; dfStdP1: double;
          dfStdP2: double; dfCenterLat: double; dfCenterLong: double;
          dfFalseEasting: double; dfFalseNorthing: double): OGRErr;
          cdecl; external LibName;

{ Lambert Conformal Conic 1SP }
function OSRSetLCC1SP(hSRS: OGRSpatialReferenceH; dfCenterLat: double;
          dfCenterLong: double; dfScale: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Lambert Conformal Conic (Belgium) }
function OSRSetLCCB(hSRS: OGRSpatialReferenceH; dfStdP1: double;
          dfStdP2: double; dfCenterLat: double; dfCenterLong: double;
          dfFalseEasting: double; dfFalseNorthing: double): OGRErr;
          cdecl; external LibName;

{ Miller Cylindrical }
function OSRSetMC(hSRS: OGRSpatialReferenceH; dfCenterLat: double;
          dfCenterLong: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Mercator }
function OSRSetMercator(hSRS: OGRSpatialReferenceH; dfCenterLat: double;
          dfCenterLong: double; dfScale: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Mollweide }
function OSRSetMollweide(hSRS: OGRSpatialReferenceH; dfCentralMeridian: double;
          dfFalseEasting: double; dfFalseNorthing: double): OGRErr;
          cdecl; external LibName;

{ New Zealand Map Grid }
function OSRSetNZMG(hSRS: OGRSpatialReferenceH; dfCenterLat: double;
          dfCenterLong: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Oblique Stereographic }
function OSRSetOS(hSRS: OGRSpatialReferenceH; dfOriginLat: double;
          dfCMeridian: double; dfScale: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Orthographic }
function OSRSetOrthographic(hSRS: OGRSpatialReferenceH; dfCenterLat: double;
          dfCenterLong: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Polyconic }
function OSRSetPolyconic(hSRS: OGRSpatialReferenceH; dfCenterLat: double;
          dfCenterLong: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Polar Stereographic }
function OSRSetPS(hSRS: OGRSpatialReferenceH; dfCenterLat: double;
          dfCenterLong: double; dfScale: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Robinson }
function OSRSetRobinson(hSRS: OGRSpatialReferenceH; dfCenterLong: double;
          dfFalseEasting: double; dfFalseNorthing: double): OGRErr;
          cdecl; external LibName;

{ Sinusoidal }
function OSRSetSinusoidal(hSRS: OGRSpatialReferenceH; dfCenterLong: double;
          dfFalseEasting: double; dfFalseNorthing: double): OGRErr;
          cdecl; external LibName;

{ Stereographic }
function OSRSetStereographic(hSRS: OGRSpatialReferenceH; dfCenterLat: double;
          dfCenterLong: double; dfScale: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Swiss Oblique Cylindrical }
function OSRSetSOC(hSRS: OGRSpatialReferenceH; dfLatitudeOfOrigin: double;
          dfCentralMeridian: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Transverse Mercator }
function OSRSetTM(hSRS: OGRSpatialReferenceH; dfCenterLat: double;
          dfCenterLong: double; dfScale: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Transverse Mercator variant }
function OSRSetTMVariant(hSRS: OGRSpatialReferenceH; pszVariantName: PChar;
          dfCenterLat: double; dfCenterLong: double; dfScale: double;
          dfFalseEasting: double; dfFalseNorthing: double): OGRErr;
          cdecl; external LibName;

{ Tunesia Mining Grid }
function OSRSetTMG(hSRS: OGRSpatialReferenceH; dfCenterLat: double;
          dfCenterLong: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ Transverse Mercator (South Oriented) }
function OSRSetTMSO(hSRS: OGRSpatialReferenceH; dfCenterLat: double;
          dfCenterLong: double; dfScale: double; dfFalseEasting: double;
          dfFalseNorthing: double): OGRErr; cdecl; external LibName;

{ VanDerGrinten }
function OSRSetVDG(hSRS: OGRSpatialReferenceH; dfCenterLong: double;
          dfFalseEasting: double; dfFalseNorthing: double): OGRErr;
          cdecl; external LibName;

{ Wagner I -- VII }
function OSRSetWagner(hSRS: OGRSpatialReferenceH; nVariation: longint;
          dfFalseEasting: double; dfFalseNorthing: double): OGRErr;
          cdecl; external LibName;

procedure OSRCleanup; cdecl; external LibName;


{ OGRCoordinateTransform API }
function OCTNewCoordinateTransformation(hSourceSRS: OGRSpatialReferenceH;
          hTargetSRS: OGRSpatialReferenceH): OGRCoordinateTransformationH;
          cdecl; external LibName;

procedure OCTDestroyCoordinateTransformation(hCT: OGRCoordinateTransformationH);
          cdecl; external LibName;

//function OCTTransform(hCT: OGRCoordinateTransformationH; nCount: longint; x: pdouble; y: pdouble; z: pdouble): longint;
//function OCTTransformEx(hCT: OGRCoordinateTransformationH; nCount: longint; x: pdouble; y: pdouble; z: pdouble; pabSuccess: plongint): longint;

{ this is really private to OGR }
//function OCTProj4Normalize(pszProj4Src: CPChar): CPCchar;


{ Projection transform dictionary query }
function OPTGetProjectionMethods(): PCPChar; cdecl; external LibName;

function OPTGetParameterList(pszProjectionMethod: CPChar;
          ppszUserName: PCPChar): PCPChar; cdecl; external LibName;

function OPTGetParameterInfo(pszProjectionMethod: CPChar;
          pszParameterName: CPChar; ppszUserName: PCPChar; ppszType: PCPChar;
          pdfDefaultValue: pdouble): longint; cdecl; external LibName;

//----------------------------------------------------------------------------

implementation

end.
