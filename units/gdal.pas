{
  Delphi API for GDAL library

  Copyright (C) 2010 Alexander Bruy (alexander.bruy@gmail.com)

  Based on the sources automatically converted by H2Pas 1.0.0
  The original files are: gdal.h

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
 * $Id: gdal.h 17687 2009-09-25 13:43:56Z dron $
 *
 * Project:  GDAL Core
 * Purpose:  GDAL Core C/Public declarations.
 * Author:   Frank Warmerdam, warmerdam@pobox.com
 *
 ******************************************************************************
 * Copyright (c) 1998, 2002 Frank Warmerdam
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

unit gdal;

interface

uses
  gdalcore;

//----------------------------------------------------------------------------
const
  { "well known" metadata items }
  GDALMD_AREA_OR_POINT = 'AREA_OR_POINT';
  GDALMD_AOP_AREA      = 'Area';
  GDALMD_AOP_POINT     = 'Point';

  { -------------------------------------------------------------------- }
  {      GDAL Specific error codes.                                      }
  {                                                                      }
  {      error codes 100 to 299 reserved for GDAL.                       }
  { -------------------------------------------------------------------- }
  CPLE_WrongFormat = 200;

  GDAL_DMD_LONGNAME           = 'DMD_LONGNAME';
  GDAL_DMD_HELPTOPIC          = 'DMD_HELPTOPIC';
  GDAL_DMD_MIMETYPE           = 'DMD_MIMETYPE';
  GDAL_DMD_EXTENSION          = 'DMD_EXTENSION';
  GDAL_DMD_CREATIONOPTIONLIST = 'DMD_CREATIONOPTIONLIST';
  GDAL_DMD_CREATIONDATATYPES  = 'DMD_CREATIONDATATYPES';

  GDAL_DCAP_CREATE     = 'DCAP_CREATE';
  GDAL_DCAP_CREATECOPY = 'DCAP_CREATECOPY';
  GDAL_DCAP_VIRTUALIO  = 'DCAP_VIRTUALIO';

  GMF_ALL_VALID   = $01;
  GMF_PER_DATASET = $02;
  GMF_ALPHA       = $04;
  GMF_NODATA      = $08;

//----------------------------------------------------------------------------
type
  { Pixel data types }
  GDALDataType =
  (
    GDT_Unknown   = 0,   { Unknown or unspecified type }
    GDT_Byte      = 1,   { Eight bit unsigned integer }
    GDT_UInt16    = 2,   { Sixteen bit unsigned integer }
    GDT_Int16     = 3,   { Sixteen bit signed integer }
    GDT_UInt32    = 4,   { Thirty two bit unsigned integer }
    GDT_Int32     = 5,   { Thirty two bit signed integer }
    GDT_Float32   = 6,   { Thirty two bit floating point }
    GDT_Float64   = 7,   { Sixty four bit floating point }
    GDT_CInt16    = 8,   { Complex Int16 }
    GDT_CInt32    = 9,   { Complex Int32 }
    GDT_CFloat32  = 10,  { Complex Float32 }
    GDT_CFloat64  = 11,  { Complex Float64 }
    GDT_TypeCount = 12   { maximum type # + 1 }
  );

  {Flag indicating read/write, or read-only access to data.}
  GDALAccess =
  (
    GA_ReadOnly = 0,  { Read only (no update) access }
    GA_Update   = 1   { Read/write access }
  );

  { Read/Write flag for RasterIO() method }
  GDALRWFlag =
  (
    GF_Read  = 0,  { Read data }
    GF_Write = 1   { Write data }
  );

  { Types of color interpretation for raster bands. }
  GDALColorInterp =
  (
    GCI_Undefined      = 0,
    GCI_GrayIndex      = 1,   { Greyscale }
    GCI_PaletteIndex   = 2,   { Paletted (see associated color table) }
    GCI_RedBand        = 3,   { Red band of RGBA image }
    GCI_GreenBand      = 4,   { Green band of RGBA image }
    GCI_BlueBand       = 5,   { Blue band of RGBA image }
    GCI_AlphaBand      = 6,   { Alpha (0=transparent, 255=opaque) }
    GCI_HueBand        = 7,   { Hue band of HLS image }
    GCI_SaturationBand = 8,   { Saturation band of HLS image }
    GCI_LightnessBand  = 9,   { Lightness band of HLS image }
    GCI_CyanBand       = 10,  { Cyan band of CMYK image }
    GCI_MagentaBand    = 11,  { Magenta band of CMYK image }
    GCI_YellowBand     = 12,  { Yellow band of CMYK image }
    GCI_BlackBand      = 13,  { Black band of CMLY image }
    GCI_YCbCr_YBand    = 14,  { Y Luminance }
    GCI_YCbCr_CbBand   = 15,  { Cb Chroma }
    GCI_YCbCr_CrBand   = 16,  { Cr Chroma }
    GCI_Max            = 16   { Max current value }
  );

  { Types of color interpretations for a GDALColorTable. }
  GDALPaletteInterp =
  (
    GPI_Gray = 0,  { Grayscale (in GDALColorEntry.c1) }
    GPI_RGB  = 1,  { Red, Green, Blue and Alpha in (in c1, c2, c3 and c4) }
    GPI_CMYK = 2,  { Cyan, Magenta, Yellow and Black (in c1, c2, c3 and c4) }
    GPI_HLS  = 3   { Hue, Lightness and Saturation (in c1, c2, and c3) }
  );

  { Deprecated / unused }
  GDALOptionDefinition = record
    pszOptionName: CPChar;
    pszValueType: CPChar;
    pszDescription: CPChar;
    papszOptions: PCPChar;
  end;

  { Ground Control Point }
  GDAL_GCP = record
    pszId: CPChar;       { Unique identifier, often numeric }
    pszInfo: CPChar;     { Informational message or '' }
    dfGCPPixel: double;  { Pixel (x) location of GCP on raster }
    dfGCPLine: double;   { Line (y) location of GCP on raster }
    dfGCPX: double;      { X position of GCP in georeferenced space }
    dfGCPY: double;      { Y position of GCP in georeferenced space }
    dfGCPZ: double;      { Elevation of GCP, or zero if not known }
  end;
  PGDAL_GCP = ^GDAL_GCP;

  GDALRPCInfo = record
    dfLINE_OFF: double;
    dfSAMP_OFF: double;
    dfLAT_OFF : double;
    dfLONG_OFF: double;
    dfHEIGHT_OFF: double;
    dfLINE_SCALE: double;
    dfSAMP_SCALE: double;
    dfLAT_SCALE : double;
    dfLONG_SCALE: double;
    dfHEIGHT_SCALE: double;
    adfLINE_NUM_COEFF: array[0..19] of double;
    adfLINE_DEN_COEFF: array[0..19] of double;
    adfSAMP_NUM_COEFF: array[0..19] of double;
    adfSAMP_DEN_COEFF: array[0..19] of double;
    dfMIN_LONG: double;
    dfMIN_LAT : double;
    dfMAX_LONG: double;
    dfMAX_LAT : double;
  end;

  GDALColorEntry = record
    c1: smallint;  { gray, red, cyan or hue }
    c2: smallint;  { green, magenta, or lightness }
    c3: smallint;  { blue, yellow, or saturation }
    c4: smallint;  { alpha or blackband }
  end;

  GDALRATFieldType =
  (
    GFT_Integer,  { Integer field }
    GFT_Real,     { Floating point (double) field }
    GFT_String    { String field }
  );

  GDALRATFieldUsage =
  (
    GFU_Generic    = 0,   { General purpose field. }
    GFU_PixelCount = 1,   { Histogram pixel count }
    GFU_Name       = 2,   { Class name }
    GFU_Min        = 3,   { Class range minimum }
    GFU_Max        = 4,   { Class range maximum }
    GFU_MinMax     = 5,   { Class value (min=max) }
    GFU_Red        = 6,   { Red class color (0-255) }
    GFU_Green      = 7,   { Green class color (0-255) }
    GFU_Blue       = 8,   { Blue class color (0-255) }
    GFU_Alpha      = 9,   { Alpha (0=transparent,255=opaque) }
    GFU_RedMin     = 10,  { Color Range Red Minimum }
    GFU_GreenMin   = 11,  { Color Range Green Minimum }
    GFU_BlueMin    = 12,  { Color Range Blue Minimum }
    GFU_AlphaMin   = 13,  { Color Range Alpha Minimum }
    GFU_RedMax     = 14,  { Color Range Red Maximum }
    GFU_GreenMax   = 15,  { Color Range Green Maximum }
    GFU_BlueMax    = 16,  { Color Range Blue Maximum }
    GFU_AlphaMax   = 17,  { Color Range Alpha Maximum }
    GFU_MaxCount          { Maximum GFU value }
  );

  { Define handle types related to various internal classes }

  { Opaque type used for the C bindings of the C++ GDALMajorObject class }
  GDALMajorObjectH = Pointer;

  { Opaque type used for the C bindings of the C++ GDALDataset class }
  GDALDatasetH = Pointer;

  { Opaque type used for the C bindings of the C++ GDALRasterBand class }
  GDALRasterBandH = Pointer;

  { Opaque type used for the C bindings of the C++ GDALDriver class }
  GDALDriverH = Pointer;

  { Deprecated / unused }
  GDALProjDefH = Pointer;

  { Opaque type used for the C bindings of the C++ GDALColorTable class }
  GDALColorTableH = Pointer;

  { Opaque type used for the C bindings of the C++ GDALRasterAttributeTable class }
  GDALRasterAttributeTableH = Pointer;

  GDALProgressFunc = function (dfComplete: double; pszMessage: CPChar; pProgressArg: Pointer): integer;

//----------------------------------------------------------------------------

{ Get data type size in bits }
function GDALGetDataTypeSize(eDataType: GDALDataType): longint;
         cdecl; external LibName;

{ Is data type complex? }
function GDALDataTypeIsComplex(eDataType: GDALDataType): longint;
         cdecl; external LibName;

{ Get name of data type }
function GDALGetDataTypeName(eDataType: GDALDataType): CPChar;
         cdecl; external LibName;

{ Get data type by symbolic name }
function GDALGetDataTypeByName(pszName: CPChar): GDALDataType;
         cdecl; external LibName;

{ Return the smallest data type that can fully express both input data types }
function GDALDataTypeUnion(eType1: GDALDataType;
                           eType2: GDALDataType): GDALDataType;
                           cdecl; external LibName;

{ Get name of color interpretation }
function GDALGetColorInterpretationName(eInterp: GDALColorInterp): CPChar;
         cdecl; external LibName;

{ Get color interpreation by symbolic name }
function GDALGetColorInterpretationByName(pszName: CPChar): GDALColorInterp;
         cdecl; external LibName;

{ Get name of palette interpretation }
function GDALGetPaletteInterpretationName(eInterp: GDALPaletteInterp): CPChar;
         cdecl; external LibName;

{ -------------------------------------------------------------------- }
{      Callback "progress" function.                                   }
{ -------------------------------------------------------------------- }
{ Stub progress function }
function GDALDummyProgress(dfComplete: double; pszMessage: CPChar;
                           pData: Pointer): longint; cdecl; external LibName;

{ Simple progress report to terminal }
function GDALTermProgress(dfComplete: double; pszMessage: CPChar;
                          pProgressArg: Pointer): longint;
                          cdecl; external LibName;

{ Scaled progress transformer }
function GDALScaledProgress(dfComplete: double; pszMessage: CPChar;
                            pData: Pointer): longint; cdecl; external LibName;

{ Create scaled progress transformer }
function GDALCreateScaledProgress(dfMin: double; dfMax: double;
                                  pfnProgress: GDALProgressFunc;
                                  pData: Pointer): Pointer;
                                  cdecl; external LibName;

{ Cleanup scaled progress handle }
procedure GDALDestroyScaledProgress(pData: Pointer); cdecl; external LibName;

{ ==================================================================== }
{      Registration/driver related.                                    }
{ ==================================================================== }

{ Register all known configured GDAL drivers }
procedure GDALAllRegister; cdecl; external LibName;

{ Create a new dataset with this driver }
function GDALCreate(hDriver: GDALDriverH; pszFilename: CPChar;
                    nXSize3: longint; nYSize: longint; nBands: longint;
                    eBandType: GDALDataType;
                    papszOptions: PCPChar): GDALDatasetH;
                    cdecl; external LibName;

{ Create a copy of a dataset }
function GDALCreateCopy(hDriver: GDALDriverH; pszFilename: CPChar;
                        hSrcDS: GDALDatasetH; bStrict: longint;
                        papszOptions: PCPChar; pfnProgress: GDALProgressFunc;
                        pProgressData: Pointer): GDALDatasetH;
                        cdecl; external LibName;

{ Identify the driver that can open a raster file }
function GDALIdentifyDriver(pszFilename: CPChar;
                            papszFileList: PCPChar): GDALDriverH;
                            cdecl; external LibName;

{ Open a raster file as a GDALDataset }
function GDALOpen(pszFilename: CPChar; eAccess: GDALAccess): GDALDatasetH;
         cdecl; external LibName;

{ Open a raster file as a GDALDataset.
  This function works the same as GDALOpen(), but allows the sharing of
  GDALDataset handles for a dataset with other callers to GDALOpenShared()
}
function GDALOpenShared(pszFilename: CPChar; eAccess: GDALAccess): GDALDatasetH;
         cdecl; external LibName;

{ List open datasets }
function GDALDumpOpenDatasets(fp: Pointer): longint; cdecl; external LibName;

{ Fetch a driver based on the short name }
function GDALGetDriverByName(pszName: CPChar): GDALDriverH;
         cdecl; external LibName;

{ Fetch the number of registered drivers }
function GDALGetDriverCount: longint; cdecl; external LibName;

{ Fetch driver by index }
function GDALGetDriver(iDriver: longint): GDALDriverH;
         cdecl; external LibName;

{ Destroy a GDALDriver }
procedure GDALDestroyDriver(hDriver: GDALDriverH); cdecl; external LibName;

{ Register a driver for use }
function GDALRegisterDriver(hDriver: GDALDriverH): longint;
         cdecl; external LibName;

{ Deregister the passed driver }
procedure GDALDeregisterDriver(hDriver: GDALDriverH); cdecl; external LibName;

{ Destroy the driver manager. Incidently unloads all managed drivers }
procedure GDALDestroyDriverManager; cdecl; external LibName;

{ Delete named dataset }
function GDALDeleteDataset(hDriver: GDALDriverH; pszFilename: CPChar): CPLErr;
         cdecl; external LibName;

{ Rename a dataset }
function GDALRenameDataset(hDriver: GDALDriverH; pszNewName: CPChar;
                           pszOldName: CPChar): CPLErr;
                           cdecl; external LibName;

{ Copy the files of a dataset }
function GDALCopyDatasetFiles(hDriver: GDALDriverH; pszNewName: CPChar;
                              pszOldName: CPChar): CPLErr;
                              cdecl; external LibName;

{ Validate the list of creation options that are handled by a driver }
function GDALValidateCreationOptions(hDriver: GDALDriverH;
                                     papszCreationOptions: PCPChar): longint;
                                     cdecl; external LibName;

{ The following are deprecated }
{ Return the short name of a driver }
function GDALGetDriverShortName(hDriver: GDALDriverH): CPChar;
         cdecl; external LibName;

{ Return the long name of a driver }
function GDALGetDriverLongName(hDriver: GDALDriverH): CPChar;
         cdecl; external LibName;

{ Return the URL to the help that describes the driver }
function GDALGetDriverHelpTopic(hDriver: GDALDriverH): CPChar;
         cdecl; external LibName;

{ Return the list of creation options of the driver }
function GDALGetDriverCreationOptionList(hDriver: GDALDriverH): CPChar;
         cdecl; external LibName;

{ ==================================================================== }
{      GDAL_GCP                                                        }
{ ==================================================================== }
procedure GDALInitGCPs(_para1: longint; _para2: PGDAL_GCP); cdecl; external LibName;

procedure GDALDeinitGCPs(_para1: longint; _para2: PGDAL_GCP); cdecl; external LibName;

function GDALDuplicateGCPs(_para1: longint; _para2: PGDAL_GCP): PGDAL_GCP; cdecl; external LibName;

{ Generate Geotransform from GCPs }
function GDALGCPsToGeoTransform(nGCPCount: longint; pasGCPs: PGDAL_GCP;
                                padfGeoTransform: Pdouble; bApproxOK: longint): longint;
                                cdecl; external LibName;

{ Invert Geotransform }
function GDALInvGeoTransform(padfGeoTransformIn: Pdouble;
                             padfInvGeoTransformOut: Pdouble): longint;
                             cdecl; external LibName;

{ Apply GeoTransform to x/y coordinate }
procedure GDALApplyGeoTransform(padfGeoTransform: Pdouble; dfPixel: double;
                                dfLine: double; pdfGeoX: Pdouble;
                                pdfGeoY: Pdouble); cdecl; external LibName;

{ ==================================================================== }
{      major objects (dataset, and, driver, drivermanager).            }
{ ==================================================================== }

{ Fetch metadata }
function GDALGetMetadata(hObject: GDALMajorObjectH; pszDomain: CPChar): PCPChar;
         cdecl; external LibName;

{ Set metadata }
function GDALSetMetadata(hObject: GDALMajorObjectH; papszMD: PCPChar;
                         pszDomain: CPChar): CPLErr; cdecl; external LibName;

{ Fetch single metadata item }
function GDALGetMetadataItem(hObject: GDALMajorObjectH; pszName: CPChar;
                             pszDomain3: CPChar): CPChar;
                             cdecl; external LibName;

{ Set single metadata item }
function GDALSetMetadataItem(hObject: GDALMajorObjectH; pszName: CPChar;
                             pszValue: CPChar; pszDomain: CPChar): CPLErr;
                             cdecl; external LibName;

{ Fetch object description }
function GDALGetDescription(hObject: GDALMajorObjectH): CPChar;
         cdecl; external LibName;

{ Set object description }
procedure GDALSetDescription(hObject: GDALMajorObjectH; pszNewDesc: CPChar);
          cdecl; external LibName;

{ ==================================================================== }
{      GDALDataset class ... normally this represents one file.        }
{ ==================================================================== }

{ Fetch the driver to which this dataset relates }
function GDALGetDatasetDriver(hDataset: GDALDatasetH): GDALDriverH;
         cdecl; external LibName;

{ Fetch files forming dataset }
function GDALGetFileList(hDS: GDALDatasetH): PCPChar; cdecl; external LibName;

{ Close GDAL dataset }
procedure GDALClose(hDS: GDALDatasetH); cdecl; external LibName;

{ Fetch raster width in pixels }
function GDALGetRasterXSize(hDataset: GDALDatasetH): longint;
         cdecl; external LibName;

{ Fetch raster height in pixels }
function GDALGetRasterYSize(hDataset: GDALDatasetH): longint;
         cdecl; external LibName;

{ Fetch the number of raster bands on this dataset }
function GDALGetRasterCount(hDS: GDALDatasetH): longint;
         cdecl; external LibName;

{ Fetch a band object for a dataset }
function GDALGetRasterBand(hDS: GDALDatasetH;
                           nBandId: longint): GDALRasterBandH;
                           cdecl; external LibName;

{ Add a band to a dataset }
function GDALAddBand(hDS: GDALDatasetH; eType: GDALDataType;
                     papszOptions: PCPChar): CPLErr; cdecl; external LibName;

{ Read/write a region of image data from multiple bands }
function GDALDatasetRasterIO(hDS: GDALDatasetH; eRWFlag: GDALRWFlag;
                             nDSXOff: longint; nDSYOff: longint;
                             nDSXSize: longint; nDSYSize: longint;
                             pBuffer: Pointer; nBXSize: longint;
                             nBYSize: longint; eBDataType: GDALDataType;
                             nBandCount: longint; panBandCount: Plongint;
                             nPixelSpace: longint; nLineSpace: longint;
                             nBandSpace: longint): CPLErr;
                             cdecl; external LibName;

{ Advise driver of upcoming read requests }
function GDALDatasetAdviseRead(hDS: GDALDatasetH; nDSXOff: longint;
                               nDSYOff: longint; nDSXSize: longint;
                               nDSYSize: longint; nBXSize: longint;
                               nBYSize: longint; eBDataType: GDALDataType;
                               nBandCount: longint; panBandCount: Plongint;
                               papszOptions: PCPChar): CPLErr;
                               cdecl; external LibName;

{ Fetch the projection definition string for this dataset }
function GDALGetProjectionRef(hDS: GDALDatasetH): CPChar;
         cdecl; external LibName;

{ Set the projection reference string for this dataset }
function GDALSetProjection(hDS: GDALDatasetH; pszProjection: CPChar): CPLErr;
         cdecl; external LibName;

{ Fetch the affine transformation coefficients }
function GDALGetGeoTransform(hDS: GDALDatasetH; padfTransform: Pdouble): CPLErr;
         cdecl; external LibName;

{ Set the affine transformation coefficients }
function GDALSetGeoTransform(hDS: GDALDatasetH; padfTransform: Pdouble): CPLErr;
         cdecl; external LibName;

{ Get number of GCPs }
function GDALGetGCPCount(hDS: GDALDatasetH): longint; cdecl; external LibName;

{ Get output projection for GCPs }
function GDALGetGCPProjection(hDS: GDALDatasetH): CPChar;
         cdecl; external LibName;

{ Fetch GCPs }
function GDALGetGCPs(hDS: GDALDatasetH): PGDAL_GCP; cdecl; external LibName;

{ Assign GCPs }
function GDALSetGCPs(hDS: GDALDatasetH; nGCPCount: longint;
                     pasGCPList: PGDAL_GCP; pszGCPProjection: CPChar): CPLErr;
                     cdecl; external LibName;

{ Fetch a format specific internally meaningful handle }
function GDALGetInternalHandle(hDS: GDALDatasetH; pszRequest: CPChar): Pointer;
         cdecl; external LibName;

{ Add one to dataset reference count }
function GDALReferenceDataset(hDataset: GDALDatasetH): longint;
         cdecl; external LibName;

{ Subtract one from dataset reference count }
function GDALDereferenceDataset(hDataset: GDALDatasetH): longint;
         cdecl; external LibName;

{ Build raster overview(s) }
function GDALBuildOverviews(hDataset: GDALDatasetH; pszResampling: CPChar;
                            nOverviews: longint; panOverviewList: Plongint;
                            nListBands: longint; panBandList: Plongint;
                            pfnProgress: GDALProgressFunc;
                            pProgressData: Pointer): CPLErr;
                            cdecl; external LibName;

{ Fetch all open GDAL dataset handles }
procedure GDALGetOpenDatasets(hDS: GDALDatasetH; pnCount: Plongint);
          cdecl; external LibName;

{ Return access flag }
function GDALGetAccess(hDS: GDALDatasetH): longint; cdecl; external LibName;

{ Flush all write cached data to disk }
procedure GDALFlushCache(hDS: GDALDatasetH); cdecl; external LibName;

{ Adds a mask band to the dataset }
function GDALCreateDatasetMaskBand(hDS: GDALDatasetH; nFlags: longint): CPLErr;
         cdecl; external LibName;

function GDALDatasetCopyWholeRaster(hSrcDS: GDALDatasetH; hDstDS: GDALDatasetH;
                                    papszOptions: PCPChar;
                                    pfnProgress: GDALProgressFunc;
                                    pProgressData: Pointer): CPLErr;
                                    cdecl; external LibName;

{ Generate downsampled overviews }
function GDALRegenerateOverviews(hSrcBand: GDALRasterBandH;
                                 nOverviewCount: longint;
                                 pahOverviewBands: GDALRasterBandH;
                                 pszResampling: CPChar;
                                 pfnProgress: GDALProgressFunc;
                                 pProgressData: Pointer): CPLErr;
                                 cdecl; external LibName;

{ ==================================================================== }
{      GDALRasterBand ... one band/channel in a dataset.               }
{ ==================================================================== }

{ Fetch the pixel data type for this band }
function GDALGetRasterDataType(hBand: GDALRasterBandH): GDALDataType;
         cdecl; external LibName;

{ Fetch the "natural" block size of this band }
procedure GDALGetBlockSize(hBand: GDALRasterBandH; pnXSize: Plongint;
                           pnYSize: Plongint); cdecl; external LibName;

{ Advise driver of upcoming read requests }
function GDALRasterAdviseRead(hBand: GDALRasterBandH; nDSXOff: longint;
                              nDSYOff: longint; nDSXSize: longint;
                              nDSYSize: longint; nBXSize: longint;
                              nBYSize: longint; eBDataType: GDALDataType;
                              papszOptions: PCPChar): CPLErr;
                              cdecl; external LibName;

{ Read/write a region of image data for this band }
function GDALRasterIO(hBand: GDALRasterBandH; eRWFlag: GDALRWFlag;
                      nDSXOff: longint; nDSYOff: longint;
                      nDSXSize: longint; nDSYSize: longint;
                      pBuffer: Pointer; nBXSize: longint;
                      nBYSize: longint; eBDataType: GDALDataType;
                      nPixelSpace: longint; nLineSpace: longint): CPLErr;
                      cdecl; external LibName;

{ Read a block of image data efficiently }
function GDALReadBlock(hBand: GDALRasterBandH; nXOff: longint; nYOff: longint;
                       pData: Pointer): CPLErr; cdecl; external LibName;

{ Write a block of image data efficiently }
function GDALWriteBlock(hBand: GDALRasterBandH; nXOff: longint; nYOff: longint;
                        pData: Pointer): CPLErr; cdecl; external LibName;

{ Fetch XSize of raster }
function GDALGetRasterBandXSize(hBand: GDALRasterBandH): longint;
         cdecl; external LibName;

{ Fetch YSize of raster }
function GDALGetRasterBandYSize(hBand: GDALRasterBandH): longint;
         cdecl; external LibName;

{ Find out if we have update permission for this band }
function GDALGetRasterAccess(hBand: GDALRasterBandH): GDALAccess;
         cdecl; external LibName;

{ Fetch the band number }
function GDALGetBandNumber(hBand: GDALRasterBandH): longint;
         cdecl; external LibName;

{ Fetch the owning dataset handle }
function GDALGetBandDataset(hBand: GDALRasterBandH): GDALDatasetH;
         cdecl; external LibName;

{ How should this band be interpreted as color?  }
function GDALGetRasterColorInterpretation(hBand: GDALRasterBandH): GDALColorInterp;
         cdecl; external LibName;

{ Set color interpretation of a band }
function GDALSetRasterColorInterpretation(hBand: GDALRasterBandH;
                                          eColorInterp: GDALColorInterp): CPLErr;
                                          cdecl; external LibName;

{ Fetch the color table associated with band }
function GDALGetRasterColorTable(hBand: GDALRasterBandH): GDALColorTableH;
         cdecl; external LibName;

{ Set the raster color table }
function GDALSetRasterColorTable(hBand: GDALRasterBandH;
                                 hCT: GDALColorTableH): CPLErr;
                                 cdecl; external LibName;

{ Check for arbitrary overviews }
function GDALHasArbitraryOverviews(hBand: GDALRasterBandH): longint;
         cdecl; external LibName;

{ Return the number of overview layers available }
function GDALGetOverviewCount(hBand: GDALRasterBandH): longint;
         cdecl; external LibName;

{ Fetch overview raster band object }
function GDALGetOverview(hBand: GDALRasterBandH; i: longint): GDALRasterBandH;
         cdecl; external LibName;

{ Fetch the no data value for this band }
function GDALGetRasterNoDataValue(hBand: GDALRasterBandH;
                                  pbSuccess: Plongint): double;
                                  cdecl; external LibName;

{ Set the no data value for this band }
function GDALSetRasterNoDataValue(hBand: GDALRasterBandH;
                                  dfValue: double): CPLErr;
                                  cdecl; external LibName;

{ Fetch the list of category names for this raster }
function GDALGetRasterCategoryNames(hBand: GDALRasterBandH): PCPChar;
         cdecl; external LibName;

{ Set the category names for this band }
function GDALSetRasterCategoryNames(hBand: GDALRasterBandH;
                                    papszNames: PCPChar): CPLErr;
                                    cdecl; external LibName;

{ Fetch the minimum value for this band }
function GDALGetRasterMinimum(hBand: GDALRasterBandH;
                              pbSuccess: Plongint): double;
                              cdecl; external LibName;

{ Fetch the maximum value for this band }
function GDALGetRasterMaximum(hBand: GDALRasterBandH;
                              pbSuccess: Plongint): double;
                              cdecl; external LibName;

{ Fetch image statistics }
function GDALGetRasterStatistics(hBand: GDALRasterBandH; bApproxOK: longint;
                                 bForce: longint; pdfMin: Pdouble;
                                 pdfMax: Pdouble; pdfMean: Pdouble;
                                 pdfStdDev: Pdouble): CPLErr;
                                 cdecl; external LibName;

{ Compute image statistics }
function GDALComputeRasterStatistics(hBand: GDALRasterBandH; bApproxOK: longint;
                                     pdfMin: Pdouble; pdfMax: Pdouble;
                                     pdfMean: Pdouble; pdfStdDev: Pdouble;
                                     pfnProgress: GDALProgressFunc;
                                     pProgressData: pointer): CPLErr;
                                     cdecl; external LibName;

{ Set statistics on band }
function GDALSetRasterStatistics(hBand: GDALRasterBandH; dfMin: double;
                                 dfMax: double; dfMean: double;
                                 dfStdDev: double): CPLErr;
                                 cdecl; external LibName;

{ Return raster unit type }
function GDALGetRasterUnitType(hBand: GDALRasterBandH): CPChar;
         cdecl; external LibName;

{ Fetch the raster value offset }
function GDALGetRasterOffset(hBand: GDALRasterBandH;
                             pbSuccess: Plongint): double;
                             cdecl; external LibName;

{ Set scaling offset }
function GDALSetRasterOffset(hBand: GDALRasterBandH;
                             dfNewOffset: double): CPLErr;
                             cdecl; external LibName;

{ Fetch the raster value scale }
function GDALGetRasterScale(hBand: GDALRasterBandH;
                            pbSuccess: Plongint): double;
                            cdecl; external LibName;

{ Set scaling ratio }
function GDALSetRasterScale(hBand: GDALRasterBandH;
                            dfNewOffset: double): CPLErr;
                            cdecl; external LibName;

{ Compute the min/max values for a band }
procedure GDALComputeRasterMinMax(hBand: GDALRasterBandH;
                                  bApproxOK: longint;
                                  adfMinMax: array of double);
                                  cdecl; external LibName;

{ Flush raster data cache }
function GDALFlushRasterCache(hBand: GDALRasterBandH): CPLErr;
         cdecl; external LibName;

{ Compute raster histogram }
function GDALGetRasterHistogram(hBand: GDALRasterBandH; dfMin: double;
                                dfMax: double; nBuckets: longint;
                                panHistogram: Plongint;
                                bIncludeOutOfRange: longint;
                                bApproxOK: longint;
                                pfnProgress: GDALProgressFunc;
                                pProgressData: Pointer): CPLErr;
                                cdecl; external LibName;

{ Fetch default raster histogram }
function GDALGetDefaultHistogram(hBand: GDALRasterBandH; pdfMin: Pdouble;
                                 pdfMax: Pdouble; pnBuckets: Plongint;
                                 ppanHistogram: PPlongint; bForce: longint;
                                 pfnProgress: GDALProgressFunc;
                                 pProgressData: Pointer): CPLErr;
                                 cdecl; external LibName;

{ Set default histogram }
function GDALSetDefaultHistogram(hBand: GDALRasterBandH; dfMin: double;
                                 dfMax: double; nBuckets: longint;
                                 panHistogram: Plongint): CPLErr;
                                 cdecl; external LibName;

function GDALGetRandomRasterSample(hBand: GDALRasterBandH; _para2: longint;
                                   _para3: Psingle): longint;
                                   cdecl; external LibName;

{ Fetch best sampling overview }
function GDALGetRasterSampleOverview(hBand: GDALRasterBandH;
                                     nDesiredSamples: longint): GDALRasterBandH;
                                     cdecl; external LibName;

{ Fill this band with a constant value }
function GDALFillRaster(hBand: GDALRasterBandH; dfRealValue: double;
                        dfImaginaryValue: double): CPLErr;
                        cdecl; external LibName;

function GDALComputeBandStats(hBand: GDALRasterBandH; nSampleStep: longint;
                              pdfMean: Pdouble; pdfStdDev: Pdouble;
                              pfnProgress: GDALProgressFunc;
                              pProgressData: pointer): CPLErr;
                              cdecl; external LibName;

function GDALOverviewMagnitudeCorrection(hBaseBand: GDALRasterBandH;
                                         nOverviewCount: longint;
                                         pahOverviews: GDALRasterBandH;
                                         pfnProgress: GDALProgressFunc;
                                         pProgressData: Pointer): CPLErr;
                                         cdecl; external LibName;

{ Fetch default Raster Attribute Table }
function GDALGetDefaultRAT(hBand: GDALRasterBandH): GDALRasterAttributeTableH;
         cdecl; external LibName;

{ Set default Raster Attribute Table }
function GDALSetDefaultRAT(hBand: GDALRasterBandH;
                           hRAT: GDALRasterAttributeTableH): CPLErr;
                           cdecl; external LibName;

{ This adds a pixel function to the global list of available pixel
  functions for derived bands
}
//function GDALAddDerivedBandPixelFunc(pszName: CPChar;
//                                     pfnPixelFunc: GDALDerivedPixelFunc): CPLErr;
//                                     cdecl; external LibName;

{ Return the mask band associated with the band }
function GDALGetMaskBand(hBand: GDALRasterBandH): GDALRasterBandH;
         cdecl; external LibName;

{ Return the status flags of the mask band associated with the band }
function GDALGetMaskFlags(hBand: GDALRasterBandH): longint;
         cdecl; external LibName;

{ Adds a mask band to the current band }
function GDALCreateMaskBand(hBand: GDALRasterBandH; nFlags: longint): CPLErr;
         cdecl; external LibName;

{ -------------------------------------------------------------------- }
{      Helper functions.                                               }
{ -------------------------------------------------------------------- }

{ General utility option processing }
function GDALGeneralCmdLineProcessor(nArgc: longint; ppapszArgv: PPPchar;
                                     nOptions: longint): longint;
                                     cdecl; external LibName;

{ Byte swap words in-place }
procedure GDALSwapWords(pData: Pointer; nWordSize: longint;
                        nWordCount: longint; nWordSkip: longint);
                        cdecl; external LibName;

procedure GDALCopyWords(pSrcData: Pointer; eSrcType: GDALDataType;
                        nSrcPixelOffset: longint; pDstData: Pointer;
                        eDstType: GDALDataType; nDstPixelOffset: longint;
                        nWordCount: longint); cdecl; external LibName;

procedure GDALCopyBits(pabySrcData: GByte; nSrcOffset: longint;
                       nSrcStep: longint; pabyDstData: GByte;
                       nDstOffset: longint; nDstStep: longint;
                       nBitCount: longint; nStepCount: longint);
                       cdecl; external LibName;

{ Read ESRI world file }
function GDALLoadWorldFile(pszFilename: CPChar; padfGeoTransform: Pdouble): longint;
         cdecl; external LibName;

{ Read ESRI world file }
function GDALReadWorldFile(pszBaseFilename: CPChar; pszExtension: CPChar;
                           padfGeoTransform: Pdouble): longint;
                           cdecl; external LibName;

{ Write ESRI world file }
function GDALWriteWorldFile(pszBaseFilename: CPChar; pszExtension: CPChar;
                            padfGeoTransform: Pdouble): longint;
                            cdecl; external LibName;

function GDALLoadTabFile(_para1: CPChar; _para2: Pdouble;
                         _para3: PCPChar; _para4: Plongint;
                         _para5: PGDAL_GCP): longint;
                         cdecl; external LibName;


function GDALReadTabFile(_para1: CPChar; _para2: Pdouble;
                         _para3: PCPChar; _para4: Plongint;
                         _para5: PGDAL_GCP): longint;
                         cdecl; external LibName;

function GDALLoadOziMapFile(_para1: CPChar; _para2: Pdouble;
                            _para3: PCPChar; _para4: Plongint;
                            _para5: PGDAL_GCP): longint;
                            cdecl; external LibName;

function GDALReadOziMapFile(_para1: CPChar; _para2: Pdouble;
                            _para3: PCPChar; _para4: Plongint;
                            _para5: PGDAL_GCP): longint;
                            cdecl; external LibName;

function GDALLoadRPBFile(pszFilename: CPChar;
                         papszSiblingFiles: PCPChar): PCPChar;
                         cdecl; external LibName;

function GDALWriteRPBFile(pszFilename: CPChar; papszMD: PCPChar): CPLErr;
         cdecl; external LibName;

function GDALLoadIMDFile(pszFilename: CPChar;
                         papszSiblingFiles: PCPChar): PCPChar;
                         cdecl; external LibName;

function GDALWriteIMDFile(pszFilename: CPChar; papszMD: PCPChar): CPLErr;
         cdecl; external LibName;

function GDALDecToDMS(_para1: double; _para2: CPChar; _para3: longint): CPChar;
         cdecl; external LibName;

{ Convert a packed DMS value (DDDMMMSSS.SS) into decimal degrees }
function GDALPackedDMSToDec(dfPacked: double): double; cdecl; external LibName;

{ Convert decimal degrees into packed DMS value (DDDMMMSSS.SS) }
function GDALDecToPackedDMS(dfDec: double): double; cdecl; external LibName;

{ Get runtime version information }
function GDALVersionInfo(pszRequest: CPChar): CPChar; cdecl; external LibName;

{ Return TRUE if GDAL library version at runtime matches
  nVersionMajor.nVersionMinor
}
function GDALCheckVersion(nVersionMajor: longint; nVersionMinor: longint;
         pszCallingComponentName: CPChar): longint; cdecl; external LibName;

function GDALExtractRPCInfo(_para1: PCPChar; _para2: GDALRPCInfo): longint;
         cdecl; external LibName;

{ ==================================================================== }
{      Color tables.                                                   }
{ ==================================================================== }

{ Construct a new color table }
function GDALCreateColorTable(eInterp: GDALPaletteInterp): GDALColorTableH;
         cdecl; external LibName;

{ Destroys a color table }
procedure GDALDestroyColorTable(hTable: GDALColorTableH);
          cdecl; external LibName;

{ Make a copy of a color table }
function GDALCloneColorTable(hTable: GDALColorTableH): GDALColorTableH;
         cdecl; external LibName;

{ Fetch palette interpretation }
function GDALGetPaletteInterpretation(hTable: GDALColorTableH): GDALPaletteInterp;
         cdecl; external LibName;

{ Get number of color entries in table }
function GDALGetColorEntryCount(hTable: GDALColorTableH): longint;
         cdecl; external LibName;

{ Fetch a color entry from table }
function GDALGetColorEntry(hTable: GDALColorTableH; i: longint): GDALColorEntry;
         cdecl; external LibName;

{ Fetch a table entry in RGB format }
function GDALGetColorEntryAsRGB(hTable: GDALColorTableH; i: longint;
                                poEntry: GDALColorEntry): longint;
                                cdecl; external LibName;

{ Set entry in color table }
procedure GDALSetColorEntry(hTable: GDALColorTableH; i: longint;
                            poEntry: GDALColorEntry);
                            cdecl; external LibName;

{ Create color ramp }
procedure GDALCreateColorRamp(hTable: GDALColorTableH; nStartIndex: longint;
                              psStartColor: GDALColorEntry;
                              nEndIndex: longint; psEndColor: GDALColorEntry);
                              cdecl; external LibName;

{ ==================================================================== }
{      Raster Attribute Table                                          }
{ ==================================================================== }

{ Construct empty table }
function GDALCreateRasterAttributeTable: GDALRasterAttributeTableH;
         cdecl; external LibName;

{ Destroys a RAT }
procedure GDALDestroyRasterAttributeTable(_para1: GDALRasterAttributeTableH);
          cdecl; external LibName;

{ Fetch table column count }
function GDALRATGetColumnCount(hRAT: GDALRasterAttributeTableH): longint;
         cdecl; external LibName;

{ Fetch name of indicated column }
function GDALRATGetNameOfCol(hRAT: GDALRasterAttributeTableH;
                             iCol: longint): CPChar;
                             cdecl; external LibName;

{ Fetch column usage value }
function GDALRATGetUsageOfCol(hRAT: GDALRasterAttributeTableH;
                              iCol: longint): GDALRATFieldUsage;
                              cdecl; external LibName;

{ Fetch column type }
function GDALRATGetTypeOfCol(hRAT: GDALRasterAttributeTableH;
                             iCol: longint): GDALRATFieldType;
                             cdecl; external LibName;

{ Fetch column index for given usage }
function GDALRATGetColOfUsage(hRAT: GDALRasterAttributeTableH;
                              eUsage: GDALRATFieldUsage): longint;
                              cdecl; external LibName;

{ Fetch row count }
function GDALRATGetRowCount(hRAT: GDALRasterAttributeTableH): longint;
         cdecl; external LibName;

{ Fetch field value as a string }
function GDALRATGetValueAsString(hRAT: GDALRasterAttributeTableH; iRow: longint;
                                 iField: longint): CPChar;
                                 cdecl; external LibName;

{ Fetch field value as a integer }
function GDALRATGetValueAsInt(hRAT: GDALRasterAttributeTableH; iRow: longint;
                              iField: longint): longint;
                              cdecl; external LibName;

{ Fetch field value as a double }
function GDALRATGetValueAsDouble(hRAT: GDALRasterAttributeTableH; iRow: longint;
                                 iField: longint): double;
                                 cdecl; external LibName;

{ Set field value from string }
procedure GDALRATSetValueAsString(hRAT: GDALRasterAttributeTableH; iRow: longint;
                                  iField: longint; pszValue: CPChar);
                                  cdecl; external LibName;

{ Set field value from integer }
procedure GDALRATSetValueAsInt(hRAT: GDALRasterAttributeTableH; iRow: longint;
                               iField: longint; nValue: longint);
                               cdecl; external LibName;

{ Set field value from double }
procedure GDALRATSetValueAsDouble(hRAT: GDALRasterAttributeTableH;
                                  iRow: longint; iField: longint;
                                  dfValue: double);
                                  cdecl; external LibName;

{ Set row count }
procedure GDALRATSetRowCount(hRAT: GDALRasterAttributeTableH;
                             nNewCount: longint);
                             cdecl; external LibName;

{ Create new column }
function GDALRATCreateColumn(hRAT: GDALRasterAttributeTableH;
                             pszFieldName: CPChar;
                             eFieldType: GDALRATFieldType;
                             eFieldUsage: GDALRATFieldUsage): CPLErr;
                             cdecl; external LibName;

{ Set linear binning information }
function GDALRATSetLinearBinning(hRAT: GDALRasterAttributeTableH;
                                 dfRow0Min: double;
                                 dfBinSize: double): CPLErr;
                                 cdecl; external LibName;

{ Get linear binning information }
function GDALRATGetLinearBinning(hRAT: GDALRasterAttributeTableH;
                                 pdfRow0Min: Pdouble;
                                 pdfBinSize: Pdouble): longint;
                                 cdecl; external LibName;

{ Initialize from color table }
function GDALRATInitializeFromColorTable(hRAT: GDALRasterAttributeTableH;
                                         hCT: GDALColorTableH): CPLErr;
                                         cdecl; external LibName;

{ Translate to a color table }
function GDALRATTranslateToColorTable(hRAT: GDALRasterAttributeTableH;
                                      nEntryCount: longint): GDALColorTableH;
                                      cdecl; external LibName;

{ Dump RAT in readable form }
procedure GDALRATDumpReadable(hRAT: GDALRasterAttributeTableH; fp: Pointer);
          cdecl; external LibName;

{ Copy Raster Attribute Table }
function GDALRATClone(hRAT: GDALRasterAttributeTableH): GDALRasterAttributeTableH;
         cdecl; external LibName;

{ Get row for pixel value }
function GDALRATGetRowOfValue(hRAT: GDALRasterAttributeTableH;
                              dfValue: double): longint;
                              cdecl; external LibName;

{ ==================================================================== }
{      GDAL Cache Management                                           }
{ ==================================================================== }

{ Set maximum cache memory }
procedure GDALSetCacheMax(nBytes: longint); cdecl; external LibName;

{ Get maximum cache memory }
function GDALGetCacheMax: longint; cdecl; external LibName;

{ Get cache memory used }
function GDALGetCacheUsed: longint; cdecl; external LibName;

{ Try to flush one cached raster block }
function GDALFlushCacheBlock: longint; cdecl; external LibName;

//----------------------------------------------------------------------------

implementation

end.
