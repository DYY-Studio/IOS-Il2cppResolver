#pragma once

#if defined(__clang__)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wtautological-undefined-compare"
#pragma clang diagnostic ignored "-Wtautological-pointer-compare"
#endif

namespace Unity
{
    struct System_String : il2cppObject
    {
        int32_t _stringLength;       // 0x8
        
        union
        {
            uint16_t _firstChar; // 0x14
            char _firstByte;     // 0x14
            wchar_t _chars[1];   // 0x14, 柔性数组成员 (或大小为1的数组，用于指针运算)
        };
        
        void Clear()
        {
            if (this == nullptr) return;
            
            memset((wchar_t*)&this->_chars[0], 0, static_cast<size_t>(_stringLength) * 2);
            this->_stringLength = 0;
        }
        
        const wchar_t* ToWideChars()
        {
            return (const wchar_t*)&this->_chars[0];
        }
        
        int32_t ToLength()
        {
            return this->_stringLength;
        }

        NSString* ToNSString()
        {
            if ((this == nullptr) || (this->ToWideChars() == nullptr) || (this->_stringLength == 0))
                return @"";
            
            const wchar_t* wideChars = this->ToWideChars();
            int32_t len = this->ToLength();

            const unichar* uniChars = (const unichar*)wideChars;
            
            NSString* nsString = [[NSString alloc] initWithCharacters:uniChars length:(NSUInteger)len];
            
            return nsString;
        }
        
        std::string ToString()
        {
            if ((this == nullptr) || (this->ToWideChars() == nullptr) || (this->ToLength() == 0))
                return "";
            
            NSString* nsString = this->ToNSString();

            if (!nsString) return "";
            std::string result([nsString UTF8String]);

            return result;
        }
    };
}

#if defined(__clang__)
#pragma clang diagnostic pop
#endif
