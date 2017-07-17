--EXEC spI_VersionReporte 1,'OSANDOVAL','Reporte 1 de Prueba','&FiltroBroCia=|1-13-7000250-2|&FiltroRamoCont=&FiltroRamoTec&FecEmision=&snReaseguro=0&NumCols=11,&strFields=,1,2,3,4,5,6,9,10,11,12,1','NAV'
ALTER PROCEDURE spI_VersionReporte( 
	@cod_modulo				INT,
	@cod_submodulo_web		INT,
	@cod_reporte			INT,
	@cod_usuario		    VARCHAR(100),
	@descripcion			VARCHAR(8000),
	@filtros				VARCHAR(8000),
	@formato				VARCHAR(100),
	@sn_Temporal			INT
)
AS
BEGIN
DECLARE @cod_config	INT = 0


SELECT @cod_config = ISNULL(MAX(cod_config),0) + 1 FROM aCRH_ConfigReportes where cod_modulo = @cod_modulo and cod_submodulo_web= @cod_submodulo_web

INSERT INTO aCRH_ConfigReportes VALUES(@cod_modulo,@cod_submodulo_web,@cod_config,@cod_reporte,@cod_usuario,@descripcion,@filtros,@formato,GETDATE(),@sn_Temporal)
	
IF @sn_Temporal = -1
BEGIN
	INSERT INTO cTMP_TablasTemporales VALUES(@cod_reporte,@cod_config,'REPORTEADOR_' + CAST(@cod_reporte AS VARCHAR) + '_' + CAST(@cod_config AS VARCHAR), GETDATE())
END

 if @@error <> 0 
        begin
            rollback transaction
            return -1
        end

 select  cod_config = @cod_config

 END



