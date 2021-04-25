$PBExportHeader$atib.sra
$PBExportComments$Generated Application Object
forward
global type atib from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type atib from application
string appname = "atib"
end type
global atib atib

on atib.create
appname = "atib"
message = create message
sqlca = create transaction
sqlda = create dynamicdescriptionarea
sqlsa = create dynamicstagingarea
error = create error
end on

on atib.destroy
destroy( sqlca )
destroy( sqlda )
destroy( sqlsa )
destroy( error )
destroy( message )
end on

