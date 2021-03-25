--transaction2
BEGIN
-- read the data and read also row version
DECLARE @Ver rowversion;
DECLARE @CreditRating INT;
select @CreditRating = CreditRating, @Ver = Ver
from dbo.RVTest
where RVTestID = 1
SELECT @Ver AS 'Version before update';
-- next do some logic that calculates the new rating value
-- ...


--next update the rating but add to where clause read row version
update dbo.RVTest
set CreditRating = 456
where RVTestID = 1 and Ver = @Ver
END