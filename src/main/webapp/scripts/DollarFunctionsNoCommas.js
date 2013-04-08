// D Smart - 2/ 3/2007

String.prototype.replaced = function (from, to)
{
  var regular = new RegExp (from, "gi");
  return this.replace (regular, to);
}

String.prototype.noCommas = function ()
{
  return this.replaced (",", "");
}

Number.prototype.comma = function ()
{
  var to = "";
  var from = String (this);
  if (from == "")
    return "";
  else
  {
    while (from.length > 3)
    {
      to = "," + from.substr (from.length - 3, 3) + to;
      from = from.substr (0, from.length - 3);
    }
    return from + to;
  }
}

function isWholeDollars (field)
{
  var fieldValue = field.value;
  if (fieldValue.length == 0)
    return false; // empty is not valid
  else
  {
    var validCharacters = "0123456789";              // "0123456789.-";
    for (i = 0; i < fieldValue.length; i++)
      if (validCharacters.indexOf (fieldValue.charAt (i)) == -1)
        return false;
    return true;
  }
}

function totalFields (totalField) // second and subsequent arguments are fields
{
  var total = 0;
  var ok = true;
  var negating = false;
  for (var i = 1; (i < arguments.length) && ok; i++)
  {
    var field = arguments[i];
    if ((field == "+") || (field == "-"))
      negating = field == "-"
    else if (isWholeDollars (field))
    {
      var fieldValue = parseInt (field.value,10);
      if (negating)
        total -= fieldValue;
      else
        total += fieldValue;
    }
    else
      ok = false;
  }
  if (ok)
    totalField.value = total;
  else
    totalField.value = "---";
  if (typeof (totalField.onchange) == "function")
    totalField.onchange ();
}