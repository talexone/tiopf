�
 TFORMPERSON 0�  TPF0TFormPerson
FormPersonLeft[TopcWidth�Height�CaptionPerson detailsColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrderOnShowFormShowPixelsPerInch`
TextHeight 	TGroupBox	GroupBox1Left Top Width�HeightQAlignalTopCaption Name details TabOrder  TLabelLabel3LeftTopWidth1HeightCaption
&Last nameFocusControlEditLastName  TLabelLabel4LeftTop4Width0HeightCaption&First nameFocusControlEditFirstName  TLabelLabel5Left� TopWidthHeightCaption	&InitialsFocusControlEditInitials  TLabelLabel6Left� Top4WidthHeightCaption&Title  TDBEditEditLastNameLeftPTopWidth}Height	DataFieldLastName
DataSourcedsPeopleTabOrder   TDBEditEditFirstNameLeftPTop0Width}Height	DataField	FirstName
DataSourcedsPeopleTabOrder  TDBEditEditInitialsLeftTopWidth}Height	DataFieldInitials
DataSourcedsPeopleTabOrder  TDBComboBox	EditTitleLeftTop0Width}HeightStylecsDropDownList	DataFieldTitle
DataSourcedsPeople
ItemHeightItems.StringsMsMissMrsMrDrProf TabOrder   TtiSplitterPaneltiSplitterPanel2Left TopQWidth�Height%AlignedalClientColorGrabBar��� 
ColorPanel	clBtnFace
PanelStyle	spsFramedSplitterOrientationspoHorizontalKeepSplitterPosPercent	SplitterPos� SplitterPosPercentFPanel1ControlstiSplitterPanel1 Panel2ControlsPanel2  TtiSplitterPaneltiSplitterPanel1LeftTopWidth�Height� AlignedalClientColorGrabBar��� 
ColorPanel	clBtnFace
PanelStyle	spsFramedSplitterOrientationspoVerticalKeepSplitterPosPercent	SplitterPos� SplitterPosPercent+Panel1Controls	GroupBox2 Panel2Controls	GroupBox3  	TGroupBox	GroupBox2LeftTopWidth� Height� AlignalClientCaption% Phone, Fax, EMail  && Web Addresses TabOrder  TDBGridDBGrid1LeftTopWidth� Height� AlignalClient
DataSource
dsEAdrListOptionsdgTitlesdgIndicatordgColumnResize
dgColLines
dgRowLinesdgTabsdgRowSelectdgAlwaysShowSelectiondgConfirmDelete ReadOnly	TabOrder TitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style 
OnDblClickDBGrid1DblClickColumnsExpanded	FieldNameAdrsTypeAsStringTitle.CaptionAddress typeWidthKVisible	 Expanded	FieldNameCaptionWidth� Visible	    TDBNavigatorDBNavigator1LeftTop� Width� Height
DataSource
dsEAdrListVisibleButtonsnbInsertnbDeletenbEdit AlignalBottomTabOrder   	TGroupBox	GroupBox3LeftTopWidth� Height� AlignalClientCaptionPostal && Street Addresses TabOrder  TDBGridDBGrid2LeftTopWidth� Height� AlignalClient
DataSource	dsAdrListOptionsdgTitlesdgIndicatordgColumnResize
dgColLines
dgRowLinesdgTabsdgRowSelectdgAlwaysShowSelectiondgConfirmDelete ReadOnly	TabOrder TitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style 
OnDblClickDBGrid2DblClickColumnsExpanded	FieldNameAdrsTypeAsStringTitle.CaptionAddress typeWidthKVisible	 Expanded	FieldNameCaptionWidth� Visible	    TDBNavigatorDBNavigator2LeftTop� Width� Height
DataSource	dsAdrListVisibleButtonsnbInsertnbDeletenbEdit AlignalBottomTabOrder    TPanelPanel2LeftTopWidth�HeightOAlignalClient
BevelOuterbvNoneTabOrder 
DesignSize�O  TLabelLabel7LeftTopWidthHeightCaption&Notes  TDBMemoDBMemo1LeftTopWidth\HeightAnchorsakLeftakTopakRightakBottom 	DataFieldNotes
DataSourcedsPeopleTabOrder     TDataSourcedsPeopleDataSettbPeopleLeft� Top�   TDataSource
dsEAdrListDataSet	tbContactLeft>Top�   TDataSource	dsAdrListDataSet	tbAddressLeftJTop�   TTiRecordDatasettbPeopleStringWidth� ObjectClassNameTPersonObjectDepth 	AfterPosttbPeopleAfterPost
ObjectView	Left� Top�  TDataSetFieldtbPeopleEAddressList	FieldNameEAddressList  TDataSetFieldtbPeopleAddressList	FieldNameAddressList  TStringFieldtbPeopleCaption	FieldNameCaptionSize�   TStringFieldtbPeopleNotes	FieldNameNotesSize�   TStringFieldtbPeopleLastName	FieldNameLastNameSize�   TStringFieldtbPeopleFirstName	FieldName	FirstNameSize�   TStringFieldtbPeopleTitle	FieldNameTitleSize�   TStringFieldtbPeopleInitials	FieldNameInitialsSize�    TTiNestedDataset	tbContactStringWidth� ObjectClassNameTEAdrsObjectDepth AfterInserttbContactAfterEdit	AfterEdittbContactAfterEdit
ObjectViewShowDeletedOwnsObjectsDataSetFieldtbPeopleEAddressListLeft@Top�   TTiNestedDataset	tbAddressStringWidth� ObjectClassNameTAdrsObjectDepth AfterInserttbAddressAfterEdit	AfterEdittbAddressAfterEdit
ObjectViewShowDeletedOwnsObjectsDataSetFieldtbPeopleAddressListLeftKTop�    