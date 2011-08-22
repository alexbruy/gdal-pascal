{
  Delphi API for OGR Geometry, Feature, Layers, DataSource and drivers

  Copyright (C) 2010 Alexander Bruy (alexander.bruy@gmail.com)

  Based on the sources automatically converted by H2Pas 1.0.0
  The original files are: ogr_core.h, ogr_api.h

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
 * $Id: ogr_core.h 17722 2009-10-01 16:40:26Z warmerdam $
 *
 * Project:  OpenGIS Simple Features Reference Implementation
 * Purpose:  Define some core portability services for cross-platform OGR code.
 * Author:   Frank Warmerdam, warmerdam@pobox.com
 *
 ******************************************************************************
 * Copyright (c) 1999, Frank Warmerdam
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
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

{******************************************************************************
 * $Id: ogr_api.h 18226 2009-12-09 09:30:48Z chaitanya $
 *
 * Project:  OpenGIS Simple Features Reference Implementation
 * Purpose:  C API for OGR Geometry, Feature, Layers, DataSource and drivers.
 * Author:   Frank Warmerdam, warmerdam@pobox.com
 *
 ******************************************************************************
 * Copyright (c) 2002, Frank Warmerdam
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
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
  gdalcore;

//----------------------------------------------------------------------------
const
  { ************************* ogr_core.h constants ************************* }
  OGRERR_NONE                      = 0;
  OGRERR_NOT_ENOUGH_DATA           = 1;    { not enough data to deserialize }
  OGRERR_NOT_ENOUGH_MEMORY         = 2;
  OGRERR_UNSUPPORTED_GEOMETRY_TYPE = 3;
  OGRERR_UNSUPPORTED_OPERATION     = 4;
  OGRERR_CORRUPT_DATA              = 5;
  OGRERR_FAILURE                   = 6;
  OGRERR_UNSUPPORTED_SRS           = 7;
  OGRERR_INVALID_HANDLE            = 8;

  wkb25DBit = $80000000;

  ogrZMarker = $21125711;

  OGRNullFID     = -1;
  OGRUnsetMarker = -21121;

  { Constants from ogrsf_frmts.h for capabilities }
  OLCRandomRead         = 'RandomRead';
  OLCSequentialWrite    = 'SequentialWrite';
  OLCRandomWrite        = 'RandomWrite';
  OLCFastSpatialFilter  = 'FastSpatialFilter';
  OLCFastFeatureCount   = 'FastFeatureCount';
  OLCFastGetExtent      = 'FastGetExtent';
  OLCCreateField        = 'CreateField';
  OLCTransactions       = 'Transactions';
  OLCDeleteFeature      = 'DeleteFeature';
  OLCFastSetNextByIndex = 'FastSetNextByIndex';
  OLCStringsAsUTF8      = 'StringsAsUTF8';
  OLCIgnoreFields       = 'IgnoreFields';

  ODsCCreateLayer       = 'CreateLayer';
  ODsCDeleteLayer       = 'DeleteLayer';

  ODrCCreateDataSource  = 'CreateDataSource';
  ODrCDeleteDataSource  = 'DeleteDataSource';

  { ************************* ogr_api.h constants *************************** }

//-----------------------------------------------------------------------------
type
  { **************************** ogr_core.h types ************************** }
  OGREnvelope = packed record
    MinX: double;
    MaxX: double;
    MinY: double;
    MaxY: double;
  end;

  OGRErr = longint;

  OGRBoolean = longint;

  OGRwkbGeometryType =
  (
    wkbUnknown = 0,                      { < unknown type, non-standard }
    wkbPoint = 1,                        { < 0-dimensional geometric object, standard WKB }
    wkbLineString = 2,                   { < 1-dimensional geometric object with linear
                                             interpolation between Points, standard WKB }
    wkbPolygon = 3,                      { < planar 2-dimensional geometric object defined
                                             by 1 exterior boundary and 0 or more interior
                                             boundaries, standard WKB }
    wkbMultiPoint = 4,                   { < GeometryCollection of Points, standard WKB }
    wkbMultiLineString = 5,              { < GeometryCollection of LineStrings, standard WKB }
    wkbMultiPolygon = 6,                 { < GeometryCollection of Polygons, standard WKB }
    wkbGeometryCollection = 7,           { < geometric object that is a collection of 1
                                             or more geometric objects, standard WKB }
    wkbNone = 100,                       { < non-standard, for pure attribute records }
    wkbLinearRing = 101,                 { < non-standard, just for createGeometry() }
    wkbPoint25D = $80000001,             { < 2.5D extension as per 99-402 }
    wkbLineString25D = $80000002,        { < 2.5D extension as per 99-402 }
    wkbPolygon25D = $80000003,           { < 2.5D extension as per 99-402 }
    wkbMultiPoint25D = $80000004,        { < 2.5D extension as per 99-402 }
    wkbMultiLineString25D = $80000005,   { < 2.5D extension as per 99-402 }
    wkbMultiPolygon25D = $80000006,      { < 2.5D extension as per 99-402 }
    wkbGeometryCollection25D = $80000007 { < 2.5D extension as per 99-402 }
  );

  OGRwkbByteOrder =
  (
    wkbXDR = 0, { MSB/Sun/Motoroloa: Most Significant Byte First }
    wkbNDR = 1  { LSB/Intel/Vax: Least Significant Byte First }
  );

  { ogr_feature.h related definitions }

  { List of feature field types. This list is likely to be extended in the
    future ... avoid coding applications based on the assumption that all
    field types can be known.
  }
  OGRFieldType =
  (
    OFTInteger = 0,        { Simple 32bit integer }
    OFTIntegerList = 1,    { List of 32bit integers }
    OFTReal = 2,           { Double Precision floating point }
    OFTRealList = 3,       { List of doubles }
    OFTString = 4,         { String of ASCII chars }
    OFTStringList = 5,     { Array of strings }
    OFTWideString = 6,     { deprecated }
    OFTWideStringList = 7, { deprecated }
    OFTBinary = 8,         { Raw Binary data }
    OFTDate = 9,           { Date }
    OFTTime = 10,          { Time }
    OFTDateTime = 11,      { Date and Time }
    OFTMaxType = 11
  );

  { Display justification for field values }
  OGRJustification =
  (
    OJUndefined = 0,
    OJLeft = 1,
    OJRight = 2
  );

  { OGRFeature field attribute value union }
  OGRField = record
  end;

  { ogr_featurestyle.h related definitions }

  { OGRStyleTool derived class types (returned by GetType()) }
  ogr_style_tool_class_id =
  (
    OGRSTCNone   = 0,
    OGRSTCPen    = 1,
    OGRSTCBrush  = 2,
    OGRSTCSymbol = 3,
    OGRSTCLabel  = 4,
    OGRSTCVector = 5
  );
  OGRSTClassId = ogr_style_tool_class_id;

  { List of units supported by OGRStyleTools }
  ogr_style_tool_units_id =
  (
    OGRSTUGround = 0,
    OGRSTUPixel  = 1,
    OGRSTUPoints = 2,
    OGRSTUMM     = 3,
    OGRSTUCM     = 4,
    OGRSTUInches = 5
  );
  OGRSTUnitId = ogr_style_tool_units_id;

  { List of parameters for use with OGRStylePen }
  ogr_style_tool_param_pen_id =
  (
    OGRSTPenColor     = 0,
    OGRSTPenWidth     = 1,
    OGRSTPenPattern   = 2,
    OGRSTPenId        = 3,
    OGRSTPenPerOffset = 4,
    OGRSTPenCap       = 5,
    OGRSTPenJoin      = 6,
    OGRSTPenPriority  = 7,
    OGRSTPenLast      = 8
  );
  OGRSTPenParam = ogr_style_tool_param_pen_id;

  { List of parameters for use with OGRStyleBrush }
  ogr_style_tool_param_brush_id =
  (
    OGRSTBrushFColor   = 0,
    OGRSTBrushBColor   = 1,
    OGRSTBrushId       = 2,
    OGRSTBrushAngle    = 3,
    OGRSTBrushSize     = 4,
    OGRSTBrushDx       = 5,
    OGRSTBrushDy       = 6,
    OGRSTBrushPriority = 7,
    OGRSTBrushLast     = 8
  );
  OGRSTBrushParam = ogr_style_tool_param_brush_id;

  { List of parameters for use with OGRStyleSymbol }
  ogr_style_tool_param_symbol_id =
  (
    OGRSTSymbolId       = 0,
    OGRSTSymbolAngle    = 1,
    OGRSTSymbolColor    = 2,
    OGRSTSymbolSize     = 3,
    OGRSTSymbolDx       = 4,
    OGRSTSymbolDy       = 5,
    OGRSTSymbolStep     = 6,
    OGRSTSymbolPerp     = 7,
    OGRSTSymbolOffset   = 8,
    OGRSTSymbolPriority = 9,
    OGRSTSymbolFontName = 10,
    OGRSTSymbolOColor   = 11,
    OGRSTSymbolLast     = 12
  );
  OGRSTSymbolParam = ogr_style_tool_param_symbol_id;

  { List of parameters for use with OGRStyleLabel }
  ogr_style_tool_param_label_id =
  (
    OGRSTLabelFontName   = 0,
    OGRSTLabelSize       = 1,
    OGRSTLabelTextString = 2,
    OGRSTLabelAngle      = 3,
    OGRSTLabelFColor     = 4,
    OGRSTLabelBColor     = 5,
    OGRSTLabelPlacement  = 6,
    OGRSTLabelAnchor     = 7,
    OGRSTLabelDx         = 8,
    OGRSTLabelDy         = 9,
    OGRSTLabelPerp       = 10,
    OGRSTLabelBold       = 11,
    OGRSTLabelItalic     = 12,
    OGRSTLabelUnderline  = 13,
    OGRSTLabelPriority   = 14,
    OGRSTLabelStrikeout  = 15,
    OGRSTLabelStretch    = 16,
    OGRSTLabelAdjHor     = 17,
    OGRSTLabelAdjVert    = 18,
    OGRSTLabelHColor     = 19,
    OGRSTLabelOColor     = 20,
    OGRSTLabelLast       = 21
  );
  OGRSTLabelParam = ogr_style_tool_param_label_id;

  { **************************** ogr_api.h types *************************** }
  OGRGeometryH = Pointer;
  OGRSpatialReferenceH = Pointer;
  OGRCoordinateTransformationH = Pointer;

  { Feature related (ogr_feature.h) }
  OGRFieldDefnH = Pointer;
  OGRFeatureDefnH = Pointer;
  OGRFeatureH = Pointer;
  OGRStyleTableH = Pointer;

  { Driver related (ogrsf_frmts.h) }
  OGRLayerH = Pointer;
  OGRDataSourceH = Pointer;
  OGRSFDriverH = Pointer;

  { Style related (ogrsf_featurestyle.h) }
  OGRStyleMgrH = Pointer;
  OGRStyleToolH = Pointer;

//----------------------------------------------------------------------------

{ ************************* ogr_core.h functions *************************** }
function OGRGeometryTypeToName(eType: OGRwkbGeometryType): CPChar;
         cdecl; external LibName;

function OGRMergeGeometryTypes(eMain: OGRwkbGeometryType;
         eExtra: OGRwkbGeometryType): OGRwkbGeometryType;
         cdecl; external LibName;

function OGRParseDate(pszInput: CPChar; psOutput: OGRField;
         nOptions: longint): longint; cdecl; external LibName;

function GDALVersionInfo(pszRequest: CPChar): CPChar; cdecl; external LibName;

function GDALCheckVersion(nVersionMajor: longint; nVersionMinor: longint;
         pszCallingComponentName: CPChar): longint; cdecl; external LibName;

{ ************************** ogr_api.h functions *************************** }

{ From base OGRGeometry class }
{ Create a geometry object of the appropriate type from it's well known binary
  representation.
}
function OGR_G_CreateFromWkb(pabyData: CPChar; hSRS: OGRSpatialReferenceH;
         phGeometry: OGRGeometryH; nBytes: longint): OGRErr;
         cdecl; external LibName;

{ Create a geometry object of the appropriate type from it's well known text
  representation
}
function OGR_G_CreateFromWkt(ppszData: CPChar; hSRS: OGRSpatialReferenceH;
         phGeometry: OGRGeometryH): OGRErr; cdecl; external LibName;

{}
//function OGR_G_CreateFromFgf();

{ Destroy geometry object }
procedure OGR_G_DestroyGeometry(hGeom: OGRGeometryH);
          cdecl; external LibName;

{ Create an empty geometry of desired type }
function OGR_G_CreateGeometry(eGeometryType: OGRwkbGeometryType): OGRGeometryH;
         cdecl; external LibName;

//function OGR_G_ApproximateArcAngles();

{ Convert to polygon }
function OGR_G_ForceToPolygon(hGeom: OGRGeometryH): OGRGeometryH;
         cdecl; external LibName;

{ Convert to multipolygon }
function OGR_G_ForceToMultiPolygon(hGeom: OGRGeometryH): OGRGeometryH;
         cdecl; external LibName;

{ Convert to multipoint }
function OGR_G_ForceToMultiPoint(hGeom: OGRGeometryH): OGRGeometryH;
         cdecl; external LibName;

{ Convert to multilinestring }
function OGR_G_ForceToMultiLineString(hGeom: OGRGeometryH): OGRGeometryH;
         cdecl; external LibName;

{ Get the dimension of this geometry }
function OGR_G_GetDimension(hGeom: OGRGeometryH): longint;
         cdecl; external LibName;

{ Get the dimension of the coordinates in this geometry }
function OGR_G_GetCoordinateDimension(hGeom: OGRGeometryH): longint;
         cdecl; external LibName;

//procedure OGR_G_SetCoordinateDimension();

{ Make a copy of this object }
function OGR_G_Clone(hGeom: OGRGeometryH): OGRGeometryH;
         cdecl; external LibName;

{ Computes and returns the bounding envelope for this geometry in the passed
  psEnvelope structure
}
procedure OGR_G_GetEnvelope(hGeom: OGRGeometryH; psEnvelope: OGREnvelope);
          cdecl; external LibName;

{ Assign geometry from well known binary data }
function OGR_G_ImportFromWkb(hGeom: OGRGeometryH; pabyData: CPChar;
         nSize: longint): OGRErr; cdecl; external LibName;

{ Convert a geometry into well known binary format }
function OGR_G_ExportToWkb(hGeom: OGRGeometryH; eOrder: OGRwkbByteOrder;
         pabyDstBuffer: CPChar): OGRErr; cdecl; external LibName;

{ Returns size of related binary representation }
function OGR_G_WkbSize(hGeom: OGRGeometryH): longint;
         cdecl; external LibName;

{ Assign geometry from well known text data }
function OGR_G_ImportFromWkt(hGeom: OGRGeometryH; ppszSrcText: PCPChar): OGRErr;
         cdecl; external LibName;

{ Convert a geometry into well known text format }
function OGR_G_ExportToWkt(hGeom: OGRGeometryH; ppszSrcText: PCPChar): OGRErr;
         cdecl; external LibName;

{ Fetch geometry type }
function OGR_G_GetGeometryType(hGeom: OGRGeometryH): OGRwkbGeometryType;
         cdecl; external LibName;

{ Fetch WKT name for geometry type }
function OGR_G_GetGeometryName(hGeom: OGRGeometryH): CPChar;
         cdecl; external LibName;

{ Dump geometry in well known text format to indicated output file }
procedure OGR_G_DumpReadable(hGeom: OGRGeometryH; fp: Pointer; pszPrefix: CPChar);
          cdecl; external LibName;

{ Convert geometry to strictly 2D. In a sense this converts all Z coordinates
  to 0.0
}
procedure OGR_G_FlattenTo2D(hGeom: OGRGeometryH); cdecl; external LibName;

//procedure OGR_G_CloseRings();
//function OGR_G_CreateFromGML();
//function OGR_G_ExportToGML();
//function OGR_G_CreateFromGMLTree();
//function OGR_G_ExportToGMLTree();
//function OGR_G_ExportEnvelopeToGMLTree();
//function OGR_G_ExportToKML();
//function OGR_G_ExportToJson();
//function OGR_G_CreateGeometryFromJson();

{ Assign spatial reference to this object }
procedure OGR_G_AssignSpatialReference(hGeom: OGRGeometryH;
          hSRS: OGRSpatialReferenceH); cdecl; external LibName;

//function OGR_G_GetSpatialReference();

{ Apply arbitrary coordinate transformation to geometry }
function OGR_G_Transform(hGeom: OGRGeometryH;
         hTransform: OGRCoordinateTransformationH): OGRErr;
         cdecl; external LibName;

{ Transform geometry to new spatial reference system }
function OGR_G_TransformTo(hGeom: OGRGeometryH;
         hSRS: OGRSpatialReferenceH): OGRErr; cdecl; external LibName;

{ Modify the geometry such it has no segment longer then the given distance }
procedure OGR_G_Segmentize(hGeom: OGRGeometryH; dfMaxLength: double);
          cdecl; external LibName;

{ Do these features intersect? }
function OGR_G_Intersects(hGeom: OGRGeometryH;
         hOtherGeom: OGRGeometryH): longint; cdecl; external LibName;

{ Returns TRUE if two geometries are equivalent }
function OGR_G_Equals(hGeom: OGRGeometryH; hOther: OGRGeometryH): longint;
         cdecl; external LibName;

{ Test for disjointness. Tests if this geometry and the other geometry
  are disjoint
}
function OGR_G_Disjoint(hGeom: OGRGeometryH; hOther: OGRGeometryH): longint;
         cdecl; external LibName;

{ Test for touching. Tests if this geometry and the other geometry
  are touching
}
function OGR_G_Touches(hThis: OGRGeometryH; hOther: OGRGeometryH): longint;
         cdecl; external LibName;

{ Test for crossing. Tests if this geometry and the other geometry
  are crossing
}
function OGR_G_Crosses(hThis:OGRGeometryH; hOther: OGRGeometryH): longint;
         cdecl; external LibName;

{ Test for containment. Tests if this geometry is within the other geometry }
function OGR_G_Within(hThis: OGRGeometryH; hOther: OGRGeometryH): longint;
         cdecl; external LibName;

{ Test for containment. Tests if this geometry contains the other geometry }
function OGR_G_Contains(hThis: OGRGeometryH; hOther: OGRGeometryH): longint;
         cdecl; external LibName;

{ Test for overlap. Tests if this geometry and the other geometry overlap,
  that is their intersection has a non-zero area
}
function OGR_G_Overlaps(hThis: OGRGeometryH; hOther:OGRGeometryH): longint;
         cdecl; external LibName;

{ Compute boundary (deprecated) }
function OGR_G_GetBoundary(hTarget: OGRGeometryH): OGRGeometryH;
         cdecl; external LibName;

{ Compute convex hull }
function OGR_G_ConvexHull(hTarget: OGRGeometryH): OGRGeometryH;
         cdecl; external LibName;

{ Compute buffer of geometry }
function OGR_G_Buffer(hTarget: OGRGeometryH; dfDist: double;
         nQuadSegs: longint): OGRGeometryH; cdecl; external LibName;

{ Compute intersection }
function OGR_G_Intersection(hThis: OGRGeometryH;
         hOther: OGRGeometryH): OGRGeometryH; cdecl; external LibName;

{ Compute union }
function OGR_G_Union(hThis: OGRGeometryH;
         hOther: OGRGeometryH): OGRGeometryH; cdecl; external LibName;

{ Compute union using cascading }
function OGR_G_UnionCascaded(hThis: OGRGeometryH ): OGRGeometryH;
         cdecl; external LibName;

{ Compute difference }
function OGR_G_Difference(hThis: OGRGeometryH;
         hOther: OGRGeometryH): OGRGeometryH; cdecl; external LibName;

{ Compute symmetric difference (deprecated) }
function OGR_G_SymmetricDifference(hThis: OGRGeometryH;
         hOther: OGRGeometryH): OGRGeometryH; cdecl; external LibName;

{ Compute distance between two geometries }
function OGR_G_Distance(hFirst: OGRGeometryH;
         hOther: OGRGeometryH): double; cdecl; external LibName;

{ Compute geometry area (deprecated) }
function OGR_G_GetArea(hGeom: OGRGeometryH): double;
         cdecl; external LibName;

{ Compute the geometry centroid }
function OGR_G_Centroid(hGeom: OGRGeometryH;
         hCentroidPoint: OGRGeometryH): longint; cdecl; external LibName;

{ Clear geometry information. This restores the geometry to it's initial
  state after construction, and before assignment of actual geometry
}
procedure OGR_G_Empty(hGeom: OGRGeometryH); cdecl; external LibName;

{ Test if the geometry is empty }
function OGR_G_IsEmpty(hGeom: OGRGeometryH): longint;
         cdecl; external LibName;

{ Test if the geometry is valid }
function OGR_G_IsValid(hGeom: OGRGeometryH): longint;
         cdecl; external LibName;

{ Returns TRUE if the geometry is simple }
function OGR_G_IsSimple(hGeom: OGRGeometryH): longint;
         cdecl; external LibName;

{ Test if the geometry is a ring }
function OGR_G_IsRing(hGeom: OGRGeometryH): longint;
         cdecl; external LibName;

{ backward compatibility }
{  }
function OGR_G_Intersect(hGeom: OGRGeometryH;
         hOtherGeom: OGRGeometryH): longint; cdecl; external LibName;

{  }
function OGR_G_Equal(hGeom: OGRGeometryH;
         hOther: OGRGeometryH): longint; cdecl; external LibName;

{ Methods for getting/setting vertices in points, line strings and rings }

{ Fetch number of points from a geometry. Only wkbPoint[25D] or
  wkbLineString[25D] may return a valid value. Other geometry types will
  silently return 0
}
function OGR_G_GetPointCount(hGeom: OGRGeometryH): longint;
         cdecl; external LibName;

{ Fetch the X coordinate of a point from a geometry }
function OGR_G_GetX(hGeom: OGRGeometryH; i: longint): double;
         cdecl; external LibName;

{ Fetch the Y coordinate of a point from a geometry }
function OGR_G_GetY(hGeom: OGRGeometryH; i: longint): double;
         cdecl; external LibName;

{ Fetch the Z coordinate of a point from a geometry }
function OGR_G_GetZ(hGeom: OGRGeometryH; i: longint): double;
         cdecl; external LibName;

{ Fetch a point in line string or a point geometry }
procedure OGR_G_GetPoint(hGeom: OGRGeometryH; i: longint;
          pdfX: double; pdfY: double; pdfZ: double); cdecl; external LibName;

{ Set the location of a vertex in a point or linestring geometry }
procedure OGR_G_SetPoint(hGeom: OGRGeometryH; i: longint;
          dfX: double; dfY: double; dfZ: double); cdecl; external LibName;

{ Set the location of a vertex in a point or linestring geometry }
procedure OGR_G_SetPoint_2D(hGeom: OGRGeometryH; i: longint;
          pdfX: double; pdfY: double); cdecl; external LibName;

{ Add a point to a geometry (line string or point) }
procedure OGR_G_AddPoint(hGeom: OGRGeometryH;
          dfX: double; dfY: double; dfZ: double); cdecl; external LibName;

{ Add a point to a geometry (line string or point) }
procedure OGR_G_AddPoint_2D(hGeom: OGRGeometryH;
          dfX: double; dfY: double); cdecl; external LibName;

{ Methods for getting/setting rings and members collections }

{ Fetch the number of elements in a geometry or number of geometries
  in container
}
function OGR_G_GetGeometryCount(hGeom: OGRGeometryH): longint;
         cdecl; external LibName;

{ Fetch geometry from a geometry container }
function OGR_G_GetGeometryRef(hGeom: OGRGeometryH;
         iSubGeom: longint): OGRGeometryH; cdecl; external LibName;

{ Add a geometry to a geometry container }
function OGR_G_AddGeometry(hGeom: OGRGeometryH;
         hNewSubGeom: OGRGeometryH): OGRErr; cdecl; external LibName;

{ Add a geometry directly to an existing geometry container }
function OGR_G_AddGeometryDirectly(hGeom: OGRGeometryH;
         hNewSubGeom: OGRGeometryH): OGRErr; cdecl; external LibName;

{ Remove a geometry from an exiting geometry container }
function OGR_G_RemoveGeometry(hGeom: OGRGeometryH; iGeom: longint;
         bDelete: longint): OGRErr; cdecl; external LibName;

{ Build a ring from a bunch of arcs }
function OGRBuildPolygonFromEdges(hLines: OGRGeometryH;
         bBestEffort: longint; bAutoClose: longint; dfTolerance: double;
         peErr: OGRErr): OGRGeometryH; cdecl; external LibName;

{ Feature related (ogr_feature.h) }

{ Create a new field definition }
function OGR_Fld_Create(pszName: CPChar; eType: OGRFieldType): OGRFieldDefnH;
         cdecl; external LibName;

{ Destroy a field definition }
procedure OGR_Fld_Destroy(hDefn: OGRFieldDefnH); cdecl; external LibName;

{ Reset the name of this field }
procedure OGR_Fld_SetName(hDefn:OGRFieldDefnH; pszName: CPChar);
         cdecl; external LibName;

{ Fetch name of this field }
function OGR_Fld_GetNameRef(hDefn:OGRFieldDefnH): CPChar;
         cdecl; external LibName;

{ Fetch type of this field }
function OGR_Fld_GetType(hDefn: OGRFieldDefnH): OGRFieldType;
         cdecl; external LibName;

{ Set the type of this field. This should never be done to an OGRFieldDefn
  that is already part of an OGRFeatureDefn
}
procedure OGR_Fld_SetType(hDefn: OGRFieldDefnH; eType: OGRFieldType);
          cdecl; external LibName;

{ Get the justification for this field }
function OGR_Fld_GetJustify(hDefn: OGRFieldDefnH): OGRJustification;
         cdecl; external LibName;

{ Set the justification for this field }
procedure OGR_Fld_SetJustify(hDefn:OGRFieldDefnH;
          eJustify: OGRJustification); cdecl; external LibName;

{ Get the formatting width for this field }
function OGR_Fld_GetWidth(hDefn: OGRFieldDefnH): longint;
         cdecl; external LibName;

{ Set the formatting width for this field in characters }
procedure OGR_Fld_SetWidth(hDefn: OGRFieldDefnH; nNewWidth: longint);
          cdecl; external LibName;

{ Get the formatting precision for this field. This should normally be
  zero for fields of types other than OFTReal
}
function OGR_Fld_GetPrecision(hDefn: OGRFieldDefnH): longint;
         cdecl; external LibName;

{ Set the formatting precision for this field in characters }
procedure OGR_Fld_SetPrecision(hDefn: OGRFieldDefnH; nPrecision: longint);
          cdecl; external LibName;

{ Set defining parameters for a field in one call }
procedure OGR_Fld_Set(hDefn: OGRFieldDefnH; pszNameIn: CPChar;
          eTypeIn: OGRFieldType; nWidthIn: longint; nPrecision: longint;
          eJustifyIn: OGRJustification); cdecl; external LibName;

{ Return whether this field should be omitted when fetching features }
function OGR_Fld_IsIgnored(hDefn: OGRFieldDefnH): longint;
         cdecl; external LibName;

{ Set whether this field should be omitted when fetching features }
procedure OGR_Fld_SetIgnored(hDefn: OGRFieldDefnH; fieldIndex: longint);
          cdecl; external LibName;

{ Fetch human readable name for a field type }
function OGR_GetFieldTypeName(eType: OGRFieldType): CPChar;
         cdecl; external LibName;

{ OGRFeatureDefn }

{ Create a new feature definition object to hold the field definitions }
function OGR_FD_Create(pszName: CPChar): OGRFeatureDefnH;
         cdecl; external LibName;

{ Destroy a feature definition object and release all memory associated
  with it
}
procedure OGR_FD_Destroy(hDefn: OGRFeatureDefnH); cdecl; external LibName;

{ Drop a reference, and destroy if unreferenced }
procedure OGR_FD_Release(hDefn: OGRFeatureDefnH); cdecl; external LibName;

{ Get name of the OGRFeatureDefn passed as an argument }
function OGR_FD_GetName(hDefn: OGRFeatureDefnH): CPChar;
         cdecl; external LibName;

{ Fetch number of fields on the passed feature definition }
function OGR_FD_GetFieldCount(hDefn: OGRFeatureDefnH): longint;
         cdecl; external LibName;

{ Fetch field definition of the passed feature definition }
function OGR_FD_GetFieldDefn(hDefn: OGRFeatureDefnH;
         iField: longint): OGRFieldDefnH; cdecl; external LibName;

{ Find field by name }
function OGR_FD_GetFieldIndex(hDefn: OGRFeatureDefnH;
         pszFieldName: CPChar): longint; cdecl; external LibName;

{ Add a new field definition to the passed feature definition }
procedure OGR_FD_AddFieldDefn(hDefn: OGRFeatureDefnH;
          hNewField: OGRFieldDefnH); cdecl; external LibName;

{ Fetch the geometry base type of the passed feature definition }
function OGR_FD_GetGeomType(hDefn: OGRFeatureDefnH): OGRwkbGeometryType;
         cdecl; external LibName;

{ Assign the base geometry type for the passed layer (the same as the
  feature definition)
}
procedure OGR_FD_SetGeomType(hDefn: OGRFeatureDefnH;
          eType: OGRwkbGeometryType); cdecl; external LibName;

{ Determine whether the geometry can be omitted when fetching features }
function OGR_FD_IsGeometryIgnored(hDefn: OGRFeatureDefnH): longint;
         cdecl; external LibName;

{ Set whether the geometry can be omitted when fetching features }
procedure OGR_FD_SetGeometryIgnored(hDefn: OGRFeatureDefnH; bIgnored: longint);
          cdecl; external LibName;

{ Determine whether the style can be omitted when fetching features }
function OGR_FD_IsStyleIgnored(hDefn: OGRFeatureDefnH): longint;
         cdecl; external LibName;

{ Set whether the style can be omitted when fetching features }
procedure OGR_FD_SetStyleIgnored(hDefn: OGRFeatureDefnH; bIgnored: longint);
          cdecl; external LibName;

{ Increments the reference count by one }
function OGR_FD_Reference(hDefn: OGRFeatureDefnH): longint;
         cdecl; external LibName;

{ Decrements the reference count by one }
function OGR_FD_Dereference(hDefn: OGRFeatureDefnH): longint;
         cdecl; external LibName;

//function OGR_FD_GetReferenceCount(hDefn: OGRFeatureDefnH): longint;

{ OGRFeature }

{ Feature factory }
function OGR_F_Create(hDefn: OGRFeatureDefnH): OGRFeatureH;
         cdecl; external LibName;

{ Destroy feature }
procedure OGR_F_Destroy(hFeat: OGRFeatureH);
          cdecl; external LibName;

{ Fetch feature definition }
function OGR_F_GetDefnRef(hFeat: OGRFeatureH): OGRFeatureDefnH;
         cdecl; external LibName;

{ Set feature geometry }
function OGR_F_SetGeometryDirectly(hFeat: OGRFeatureH;
         hGeom: OGRGeometryH): OGRErr; cdecl; external LibName;

{ Set feature geometry }
function OGR_F_SetGeometry(hFeat: OGRFeatureH; hGeom: OGRGeometryH): OGRErr;
         cdecl; external LibName;

{ Fetch an handle to feature geometry }
function OGR_F_GetGeometryRef(hFeat: OGRFeatureH): OGRGeometryH;
         cdecl; external LibName;

{ Duplicate feature }
function OGR_F_Clone(hFeat: OGRFeatureH): OGRFeatureH;
         cdecl; external LibName;

{ Test if two features are the same }
function OGR_F_Equal(hFeat: OGRFeatureH; hOtherFeat: OGRFeatureH): longint;
         cdecl; external LibName;

{ Fetch number of fields on this feature This will always be the same
  as the field count for the OGRFeatureDefn
}
function OGR_F_GetFieldCount(hFeat: OGRFeatureH): longint;
         cdecl; external LibName;

{ Fetch definition for this field }
function OGR_F_GetFieldDefnRef(hFeat: OGRFeatureH;
         i: longint): OGRFieldDefnH; cdecl; external LibName;

{ Fetch the field index given field name }
function OGR_F_GetFieldIndex(hFeat: OGRFeatureH; pszName: CPChar): longint;
         cdecl; external LibName;

{ Test if a field has ever been assigned a value or not }
function OGR_F_IsFieldSet(hFeat: OGRFeatureH; iField: longint): longint;
         cdecl; external LibName;

{ Clear a field, marking it as unset }
procedure OGR_F_UnsetField(hFeat: OGRFeatureH; iField: longint);
          cdecl; external LibName;

{ Fetch an handle to the internal field value given the index }
function OGR_F_GetRawFieldRef(hFeat: OGRFeatureH;
         iField: longint): OGRField; cdecl; external LibName;

{ Fetch field value as integer }
function OGR_F_GetFieldAsInteger(hFeat: OGRFeatureH;
         iField: longint): longint; cdecl; external LibName;

{ Fetch field value as a double }
function OGR_F_GetFieldAsDouble(hFeat: OGRFeatureH;
         iField: longint): double; cdecl; external LibName;

{ Fetch field value as a string }
function OGR_F_GetFieldAsString(hFeat: OGRFeatureH;
         iField: longint): CPChar; cdecl; external LibName;

{ Fetch field value as a list of integers }
function OGR_F_GetFieldAsIntegerList(hFeat: OGRFeatureH; iField: longint;
         pnCount: longint): longint; cdecl; external LibName;

{ Fetch field value as a list of doubles }
function OGR_F_GetFieldAsDoubleList(hFeat: OGRFeatureH; iField: longint;
         pnCount: Plongint): double; cdecl; external LibName;

{ Fetch field value as a list of strings }
function OGR_F_GetFieldAsStringList(hFeat: OGRFeatureH;
         iField: longint): CPChar; cdecl; external LibName;

{ Fetch field value as binary }
function OGR_F_GetFieldAsBinary(hFeat: OGRFeatureH; iField: longint;
         pnBytes: Plongint): GByte; cdecl; external LibName;

{ Fetch field value as date and time }
function OGR_F_GetFieldAsDateTime(hFeat: OGRFeatureH; iField: longint;
         pnYear: Plongint; pnMonth: Plongint; pnDay: Plongint;
         pnHour: Plongint; pnMinute: Plongint; pnSecond: Plongint;
         pnTZFlag: Plongint): longint; cdecl; external LibName;

{ Set field to integer value }
procedure OGR_F_SetFieldInteger(hFeat: OGRFeatureH; iField: longint;
          nValue: longint); cdecl; external LibName;

{ Set field to double value }
procedure OGR_F_SetFieldDouble(hFeat: OGRFeatureH; iField: longint;
          dfValue: double); cdecl; external LibName;

{ Set field to string value }
procedure OGR_F_SetFieldString(hFeat: OGRFeatureH; iField: longint;
          pszValue: CPChar); cdecl; external LibName;

{ Set field to list of integers value }
procedure OGR_F_SetFieldIntegerList(hFeat: OGRFeatureH; iField: longint;
          nCount: longint; panValues: Plongint); cdecl; external LibName;

{ Set field to list of doubles value }
procedure OGR_F_SetFieldDoubleList(hFeat: OGRFeatureH; iField: longint;
          nCount: longint; padfValues: Pdouble); cdecl; external LibName;

{ Set field to list of strings value }
procedure OGR_F_SetFieldStringList(hFeat: OGRFeatureH; iField: longint;
          papszValues: PCPChar); cdecl; external LibName;

{ Set field }
procedure OGR_F_SetFieldRaw(hFeat: OGRFeatureH; iField: longint;
          psValue: OGRField); cdecl; external LibName;

{ Set field to binary data }
procedure OGR_F_SetFieldBinary(hFeat: OGRFeatureH; iField: longint;
          nBytes: longint; pabyData: GByte); cdecl; external LibName;

{ Set field to datetime }
procedure OGR_F_SetFieldDateTime(hFeat: OGRFeatureH; iField: longint;
          nYear: longint; nMonth: longint; nDay: longint; nHour: longint;
          nMinute:longint; nSecond: longint; nTZFlag: longint);
          cdecl; external LibName;

{ Get feature identifier }
function OGR_F_GetFID(hFeat: OGRFeatureH): longint; cdecl; external LibName;

{ Set the feature identifier }
function OGR_F_SetFID(hFeat: OGRFeatureH;
         nFID: longint): OGRErr; cdecl; external LibName;

{ Dump this feature in a human readable form }
procedure OGR_F_DumpReadable(hFeat: OGRFeatureH; fpOut: Pointer);
          cdecl; external LibName;

{ Set one feature from another }
function OGR_F_SetFrom(hFeat: OGRFeatureH; hOtherFeat: OGRFeatureH;
         bForgiving: longint): OGRErr; cdecl; external LibName;

{ Set one feature from another }
function OGR_F_SetFromWithMap(hFeat: OGRFeatureH; hOtherFeat: OGRFeatureH;
         bForgiving: longint; panMap: Plongint): OGRErr;
         cdecl; external LibName;

{ Fetch style string for this feature }
function OGR_F_GetStyleString(hFeat: OGRFeatureH): CPChar;
         cdecl; external LibName;

{ Set feature style string. This method operate exactly as
  OGR_F_SetStyleStringDirectly() except that it does not assume ownership
  of the passed string, but instead makes a copy of it
}
procedure OGR_F_SetStyleString(hFeat: OGRFeatureH; pszStyle: CPChar);
          cdecl; external LibName;

{ Set feature style string. This method operate exactly as
  OGR_F_SetStyleString() except that it assumes ownership of the passed
  string
}
procedure OGR_F_SetStyleStringDirectly(hFeat: OGRFeatureH; pszStyle: CPChar);
          cdecl; external LibName;

//function OGR_F_GetStyleTable(hFeat:OGRFeatureH):OGRStyleTableH;
//procedure OGR_F_SetStyleTableDirectly(hFeat:OGRFeatureH; _para2:OGRStyleTableH);
//procedure OGR_F_SetStyleTable(hFeat:OGRFeatureH; _para2:OGRStyleTableH);

{ OGRLayer }

{ This function returns the current spatial filter for this layer }
function OGR_L_GetSpatialFilter(hLayer: OGRLayerH): OGRGeometryH;
         cdecl; external LibName;

{ Set a new spatial filter }
procedure OGR_L_SetSpatialFilter(hLayer: OGRLayerH; hGeom: OGRGeometryH);
          cdecl; external LibName;

{ Set a new rectangular spatial filter }
procedure OGR_L_SetSpatialFilterRect(hLayer: OGRLayerH; dfMinX: double;
          dfMinY: double; dfMaxX: double; dfMaxY: double);
          cdecl; external LibName;

{ Set a new attribute query }
function OGR_L_SetAttributeFilter(hLayer: OGRLayerH;
         pszQuery: CPChar): OGRErr; cdecl; external LibName;

{ Reset feature reading to start on the first feature }
procedure OGR_L_ResetReading(hLayer: OGRLayerH); cdecl; external LibName;

{ Fetch the next available feature from this layer }
function OGR_L_GetNextFeature(hLayer: OGRLayerH): OGRFeatureH;
         cdecl; external LibName;

{ Move read cursor to the nIndex'th feature in the current resultset }
function OGR_L_SetNextByIndex(hLayer: OGRLayerH; nIndex: longint): OGRErr;
         cdecl; external LibName;

{ Fetch a feature by its identifier }
function OGR_L_GetFeature(hLayer: OGRLayerH;
         nFeatureId: longint): OGRFeatureH; cdecl; external LibName;

{ Rewrite an existing feature }
function OGR_L_SetFeature(hLayer: OGRLayerH; hFeat: OGRFeatureH): OGRErr;
         cdecl; external LibName;

{ Create and write a new feature within a layer }
function OGR_L_CreateFeature(hLayer: OGRLayerH; hFeat: OGRFeatureH): OGRErr;
         cdecl; external LibName;

{ Delete feature from layer }
function OGR_L_DeleteFeature(hLayer: OGRLayerH; nFID: longint): OGRErr;
         cdecl; external LibName;

{ Fetch the schema information for this layer }
function OGR_L_GetLayerDefn(hLayer: OGRLayerH): OGRFeatureDefnH;
         cdecl; external LibName;

{ Fetch the spatial reference system for this layer }
function OGR_L_GetSpatialRef(hLayer: OGRLayerH): OGRSpatialReferenceH;
         cdecl; external LibName;

{ Fetch the feature count in this layer }
function OGR_L_GetFeatureCount(hLayer: OGRLayerH; bForce: longint): longint;
         cdecl; external LibName;

{ Fetch the extent of this layer }
function OGR_L_GetExtent(hLayer: OGRLayerH; var psExtent: OGREnvelope;
         bForce:longint): OGRErr; cdecl; external LibName;

{ Test if this layer supported the named capability }
function OGR_L_TestCapability(hLayer: OGRLayerH; pszCap: CPChar): longint;
         cdecl; external LibName;

{ Create a new field on a layer }
function OGR_L_CreateField(hLayer: OGRLayerH; hField: OGRFieldDefnH;
         bApproxOK: longint): OGRErr; cdecl; external LibName;

{ For datasources which support transactions, StartTransaction creates
  a transaction
}
function OGR_L_StartTransaction(hLayer: OGRLayerH): OGRErr;
         cdecl; external LibName;

{ For datasources which support transactions, CommitTransaction commits
  a transaction
}
function OGR_L_CommitTransaction(hLayer: OGRLayerH): OGRErr;
         cdecl; external LibName;

{ For datasources which support transactions, RollbackTransaction will
  roll back a datasource to its state before the start of the current
  transaction. If no transaction is active, or the rollback fails, will
  return OGRERR_FAILURE. Datasources which do not support transactions
  will always return OGRERR_NONE
}
function OGR_L_RollbackTransaction(hLayer: OGRLayerH): OGRErr;
         cdecl; external LibName;

//function OGR_L_Reference(hLayer:OGRLayerH):longint;
//function OGR_L_Dereference(hLayer:OGRLayerH):longint;
//function OGR_L_GetRefCount(hLayer:OGRLayerH):longint;

{ Flush pending changes to disk }
function OGR_L_SyncToDisk(hLayer: OGRLayerH): OGRErr;
         cdecl; external LibName;

//function OGR_L_GetFeaturesRead(hLayer:OGRLayerH):GIntBig;

{ This method returns the name of the underlying database column being
  used as the FID column, or "" if not supported
}
function OGR_L_GetFIDColumn(hLayer: OGRLayerH): CPChar;
         cdecl; external LibName;

{ This method returns the name of the underlying database column being
  used as the geometry column, or "" if not supported
}
function OGR_L_GetGeometryColumn(hLayer: OGRLayerH): CPChar;
         cdecl; external LibName;

//function OGR_L_GetStyleTable(hLayer:OGRLayerH):OGRStyleTableH;
//procedure OGR_L_SetStyleTableDirectly(hLayer:OGRLayerH; _para2:OGRStyleTableH);
//procedure OGR_L_SetStyleTable(hLayer:OGRLayerH; _para2:OGRStyleTableH);

{ Set which fields can be omitted when retrieving features from the layer.

  By default, no fields are ignored.
}
function OGR_L_SetIgnoredFields(hLayer: OGRLayerH; fields: CPChar ): OGRErr;
         cdecl; external LibName;

{ OGRDataSource }

{ Closes opened datasource and releases allocated resources }
procedure OGR_DS_Destroy(hDataSource: OGRDataSourceH);
          cdecl; external LibName;

{ Returns the name of the data source }
function OGR_DS_GetName(hDS: OGRDataSourceH): CPChar;
         cdecl; external LibName;

{ Get the number of layers in this data source }
function OGR_DS_GetLayerCount(hDS: OGRDataSourceH): longint;
         cdecl; external LibName;

{ Fetch a layer by index }
function OGR_DS_GetLayer(hDS: OGRDataSourceH; iLayer: longint): OGRLayerH;
         cdecl; external LibName;

{ Fetch a layer by name }
function OGR_DS_GetLayerByName(hDS: OGRDataSourceH;
         pszLayerName: CPChar): OGRLayerH; cdecl; external LibName;

{ Delete the indicated layer from the datasource }
function OGR_DS_DeleteLayer(hDS: OGRDataSourceH; iLayer: longint): OGRErr;
         cdecl; external LibName;

{ Returns the driver that the dataset was opened with }
function OGR_DS_GetDriver(hDS: OGRDataSourceH): OGRSFDriverH;
         cdecl; external LibName;

{ This function attempts to create a new layer on the data source with
  the indicated name, coordinate system, geometry type
}
function OGR_DS_CreateLayer(hDS: OGRDataSourceH; pszName: CPChar;
         hSpatialRef: OGRSpatialReferenceH; eType: OGRwkbGeometryType;
         papszOptions: PCPChar): OGRLayerH; cdecl; external LibName;

{ Duplicate an existing layer }
function OGR_DS_CopyLayer(hDS: OGRDataSourceH; hSrcLayer: OGRLayerH;
         pszNewName: CPChar; papszOptions: PCPChar): OGRLayerH;
         cdecl; external LibName;

{ Test if capability is available }
function OGR_DS_TestCapability(hDS: OGRDataSourceH;
         pszCapability: CPChar): longint; cdecl; external LibName;

{ Execute an SQL statement against the data store }
function OGR_DS_ExecuteSQL(hDS: OGRDataSourceH; pszSQLCommand: CPChar;
         hSpatialFilter: OGRGeometryH; pszDialect: CPChar): OGRLayerH;
         cdecl; external LibName;

{ Release results of OGR_DS_ExecuteSQL() }
procedure OGR_DS_ReleaseResultSet(hDS: OGRDataSourceH; hLayer: OGRLayerH);
          cdecl; external LibName;

//function OGR_DS_Reference(hDS:OGRDataSourceH):longint;
//function OGR_DS_Dereference(hDS:OGRDataSourceH):longint;
//function OGR_DS_GetRefCount(hDS:OGRDataSourceH):longint;
//function OGR_DS_GetSummaryRefCount(hDS:OGRDataSourceH):longint;

{ Flush pending changes to disk }
function OGR_DS_SyncToDisk(hDS: OGRDataSourceH): OGRErr;
         cdecl; external LibName;

//function OGR_DS_GetStyleTable(hDS:OGRDataSourceH):OGRStyleTableH;
//procedure OGR_DS_SetStyleTableDirectly(hDS:OGRDataSourceH; _para2:OGRStyleTableH);
//procedure OGR_DS_SetStyleTable(hDS:OGRDataSourceH; _para2:OGRStyleTableH);

{ OGRSFDriver }

{ Fetch name of driver (file format). This name should be relatively short
  (10-40 characters), and should reflect the underlying file format. For
  instance "ESRI Shapefile"
}
function OGR_Dr_GetName(hDriver: OGRSFDriverH): CPChar;
         cdecl; external LibName;

{ Attempt to open file with this driver }
function OGR_Dr_Open(hDriver: OGRSFDriverH; pszName: CPChar;
         bUpdate: longint): OGRDataSourceH; cdecl; external LibName;

{ Test if capability is available }
function OGR_Dr_TestCapability(hDriver: OGRSFDriverH;
         pszCap: CPChar): longint; cdecl; external LibName;

{ This function attempts to create a new data source based on the passed
  driver
}
function OGR_Dr_CreateDataSource(hDriver: OGRSFDriverH; pszName: CPChar;
         papszOptions: PCPChar): OGRDataSourceH; cdecl; external LibName;

{ This function creates a new datasource by copying all the layers from
  the source datasource
}
function OGR_Dr_CopyDataSource(hDriver: OGRSFDriverH;
         hSrcDS: OGRDataSourceH; pszNewName: CPChar;
         papszOptions: PCPChar): OGRDataSourceH; cdecl; external LibName;

{ Delete a datasource }
function OGR_Dr_DeleteDataSource(hDriver: OGRSFDriverH;
         pszDataSource: CPChar): OGRErr; cdecl; external LibName;

{ OGRSFDriverRegistrar }

{ Open a file / data source with one of the registered drivers }
function OGROpen(pszName: CPChar; bUpdate: longint;
         pahDriverList: OGRSFDriverH): OGRDataSourceH;
         cdecl; external LibName;

//function OGROpenShared(_para1:CPChar; _para2:longint; _para3:POGRSFDriverH):OGRDataSourceH;

{ Drop a reference to this datasource, and if the reference count drops
  to zero close (destroy) the datasource
}
function OGRReleaseDataSource(hDS: OGRDataSourceH): OGRErr;
         cdecl; external LibName;

{ Add a driver to the list of registered drivers }
procedure OGRRegisterDriver(hDriver: OGRSFDriverH);
          cdecl; external LibName;

{ Remove the passed driver from the list of registered drivers }
procedure OGRDeregisterDriver(hDriver: OGRSFDriverH );
          cdecl; external LibName;

{ Fetch the number of registered drivers }
function OGRGetDriverCount: longint; cdecl; external LibName;

{ Fetch the indicated driver }
function OGRGetDriver(iDriver: longint): OGRSFDriverH;
         cdecl; external LibName;

{ Fetch the indicated driver }
function OGRGetDriverByName(pszName: CPChar): OGRSFDriverH;
         cdecl; external LibName;

{ Return the number of opened datasources }
function OGRGetOpenDSCount: longint; cdecl; external LibName;

{ Return the iDS th datasource opened }
function OGRGetOpenDS(iDS: longint): OGRDataSourceH;
         cdecl; external LibName;

{ note: this is also declared in ogrsf_frmts.h }

{ Register all drivers }
procedure OGRRegisterAll; cdecl; external LibName;

{ Cleanup all OGR related resources }
procedure OGRCleanupAll; cdecl; external LibName;

{ OGRStyleMgr }

{ OGRStyleMgr factory }
function OGR_SM_Create(hStyleTable: OGRStyleTableH): OGRStyleMgrH;
         cdecl; external LibName;

{ Destroy Style Manager }
procedure OGR_SM_Destroy(hSM: OGRStyleMgrH); cdecl; external LibName;

{ Initialize style manager from the style string of a feature }
function OGR_SM_InitFromFeature(hSM: OGRStyleMgrH;
         hFeat: OGRFeatureH): CPChar; cdecl; external LibName;

{ Initialize style manager from the style string }
function OGR_SM_InitStyleString(hSM: OGRStyleMgrH;
         pszStyleString: CPChar): longint; cdecl; external LibName;

{ Get the number of parts in a style }
function OGR_SM_GetPartCount(hSM: OGRStyleMgrH;
         pszStyleString: CPChar): longint; cdecl; external LibName;

{ Fetch a part (style tool) from the current style }
function OGR_SM_GetPart(hSM: OGRStyleMgrH; nPartId: longint;
         pszStyleString: CPChar): OGRStyleToolH; cdecl; external LibName;

{ Add a part (style tool) to the current style }
function OGR_SM_AddPart(hSM: OGRStyleMgrH; hST: OGRStyleToolH): longint;
         cdecl; external LibName;

{ Add a style to the current style table }
function OGR_SM_AddStyle(hSM: OGRStyleMgrH; pszStyleName: CPChar;
         pszStyleString: CPChar): longint; cdecl; external LibName;

{ OGRStyleTool }

{ OGRStyleTool factory }
function OGR_ST_Create(eClassId: OGRSTClassId): OGRStyleToolH;
         cdecl; external LibName;

{ Destroy Style Tool }
procedure OGR_ST_Destroy(hST: OGRStyleToolH); cdecl; external LibName;

{ Determine type of Style Tool }
function OGR_ST_GetType(hST: OGRStyleToolH): OGRSTClassId;
         cdecl; external LibName;

{ Get Style Tool units }
function OGR_ST_GetUnit(hST: OGRStyleToolH): OGRSTUnitId;
         cdecl; external LibName;

{ Set Style Tool units }
procedure OGR_ST_SetUnit(hST: OGRStyleToolH; eUnit: OGRSTUnitId;
          dfGroundPaperScale: double); cdecl; external LibName;

{ Get Style Tool parameter value as string }
function OGR_ST_GetParamStr(hST: OGRStyleToolH; eParam: longint;
         bValueIsNull: plongint): PChar; cdecl; external LibName;

{ Get Style Tool parameter value as an integer }
function OGR_ST_GetParamNum(hST: OGRStyleToolH; eParam: longint;
         bValueIsNull: plongint): longint; cdecl; external LibName;

{ Get Style Tool parameter value as a double }
function OGR_ST_GetParamDbl(hST: OGRStyleToolH; eParam: longint;
         bValueIsNull: plongint): double; cdecl; external LibName;

{ Set Style Tool parameter value from a string }
procedure OGR_ST_SetParamStr(hST: OGRStyleToolH; eParam: longint;
          pszValue: CPChar); cdecl; external LibName;

{ Set Style Tool parameter value from an integer }
procedure OGR_ST_SetParamNum(hST: OGRStyleToolH; eParam: longint;
          nValue: longint); cdecl; external LibName;

{ Set Style Tool parameter value from a double }
procedure OGR_ST_SetParamDbl(hST: OGRStyleToolH; eParam: longint;
          dfValue: double); cdecl; external LibName;

{ Get the style string for this Style Tool }
function OGR_ST_GetStyleString(hST: OGRStyleToolH): CPChar;
         cdecl; external LibName;

{ Return the r,g,b,a components of a color encoded in #RRGGBB[AA] format }
function OGR_ST_GetRGBFromString(hST: OGRStyleToolH; pszColor: CPChar;
         pnRed: plongint; pnGreen: plongint; pnBlue: plongint;
         pnAlpha: plongint): longint; cdecl; external LibName;

{ OGRStyleTable }

{ OGRStyleTable factory }
function OGR_STBL_Create: OGRStyleTableH; cdecl; external LibName;

{ Destroy Style Table }
procedure OGR_STBL_Destroy(hSTBL: OGRStyleTableH); cdecl; external LibName;

{ Save a style table to a file }
function OGR_STBL_SaveStyleTable(hStyleTable: OGRStyleTableH;
         pszFilename: CPChar): longint; cdecl; external LibName;

{ Load a style table from a file }
function OGR_STBL_LoadStyleTable(hStyleTable: OGRStyleTableH;
         pszFilename: CPChar): longint; cdecl; external LibName;

{ Get a style string by name }
function OGR_STBL_Find(hStyleTable: OGRStyleTableH;
         pszName: CPChar): CPChar; cdecl; external LibName;

{ Reset the next style pointer to 0 }
procedure OGR_STBL_ResetStyleStringReading(hStyleTable: OGRStyleTableH);
          cdecl; external LibName;

{ Get the next style string from the table }
function OGR_STBL_GetNextStyle(hStyleTable: OGRStyleTableH): CPChar;
         cdecl; external LibName;

{ Get the style name of the last style string fetched with
  OGR_STBL_GetNextStyle
}
function OGR_STBL_GetLastStyleName(hStyleTable: OGRStyleTableH): CPChar;
         cdecl; external LibName;

implementation

end.

