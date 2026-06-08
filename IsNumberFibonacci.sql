CREATE FUNCTION IsNumberFibonacci(@Number BIGINT) RETURNS BIT
AS
BEGIN
    -- Проверка, число должно быть больше 2
    IF @Number <= 2
        RETURN 0;

    -- Начальные значения последовательности Фибоначчи
    DECLARE @Fib1 BIGINT = 1; 
    DECLARE @Fib2 BIGINT = 1; 
    DECLARE @CurrentFib BIGINT = @Fib1 + @Fib2;  -- 2

    WHILE @CurrentFib < @Number
    BEGIN
        -- Вычисляем  число Фибоначчи
        SET @Fib1 = @Fib2;
        SET @Fib2 = @CurrentFib;
        SET @CurrentFib = @Fib1 + @Fib2;
    END
    -- совпало ли текущее число с проверяемым
    IF @CurrentFib = @Number
        RETURN 1;  -- Да
    ELSE
        RETURN 0;  -- Нет
END;
GO
