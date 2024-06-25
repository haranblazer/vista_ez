using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text.RegularExpressions;

/// <summary>
/// Summary description for Validation
/// </summary>
public class Validation
{
	public Validation()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public Boolean IsValidPAN(string str)
    {
        if (Regex.Match(str, @"^[a-zA-Z]{3}(p|P|c|C|h|H|f|F|a|A|t|T|b|B|l|L|j|J|g|G)[a-zA-Z][0-9]{4}[a-zA-Z]$").Success)
        {

            return true;
        }
        else
        {
            
            return false;
        }
    }

    public bool IsValidPINCode(string str)
    {
        if (Regex.Match(str, @"^[1-9]{1}[0-9]{2}\s{0,1}[0-9]{3}$").Success)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public Boolean IsValidMobile(string str)
    {
        if (Regex.Match(str, @"^[6789]\d{9}$").Success)
        {

            return true;
        }
        else
        {
            return false;
        }

    }

    public Boolean IsValidImageType(string str)
    {
        if (Regex.Match(str, @"^.*\.((j|J)(p|P)(e|E)?(g|G)|(g|G)(i|I)(f|F)|(p|P)(n|N)(g|G))$").Success)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public Boolean IsValidEmail(string str)
    {
        if (Regex.Match(str, @"^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$").Success)
        {
            return true;

        }
        else
        {
            return false;
        }
    }

    public static Boolean IsValidPassword(string str)
    {
        if (Regex.Match(str, @"[a-zA-Z0-9!@#$%^&*()]+$").Success)
            return true;
        else
            return false;
    }


    public Boolean IsAlphabets(string str)
    {
        if (Regex.Match(str, @"^[a-zA-Z][a-zA-Z\s]*$").Success)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public Boolean IsAlphaNumeric(string str)
    {
        if (Regex.Match(str, @"^[a-zA-Z0-9]*$").Success)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public Boolean IsNumeric(string str)
    {
        if (Regex.Match(str, @"^((([1-9])+)([0-9])*$)").Success)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public Boolean IsRequired(string str)
    {
        
        if(!string.IsNullOrEmpty(str))
        {
            return true;

        }
        else
        {
            return false;
        }
    }
     
    public Boolean IsAlphaNumeric_and_SpecialChar(string str)
    {
        if (Regex.Match(str, @"^[ A-Za-z0-9_@/#()]*$").Success)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

}