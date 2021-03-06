Imports System.Security.Cryptography
Imports System.Text

Public Class GetHash

    Public Shared Function GetPasswordHash(strToHash As String) As String

        Dim md5Obj As New MD5CryptoServiceProvider

        Dim bytesToHash() As Byte = Encoding.ASCII.GetBytes(strToHash)

        bytesToHash = md5Obj.ComputeHash(bytesToHash)
        Dim strResult As New StringBuilder

        For Each b As Byte In bytesToHash
            strResult.Append(b.ToString("x2"))
        Next

        Return strResult.ToString

    End Function

End Class
