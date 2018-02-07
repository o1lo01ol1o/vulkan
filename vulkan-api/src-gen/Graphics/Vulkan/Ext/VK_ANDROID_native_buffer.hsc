#include "vulkan/vulkan.h"

{-# LANGUAGE DataKinds                #-}
{-# LANGUAGE FlexibleContexts         #-}
{-# LANGUAGE FlexibleInstances        #-}
{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE MagicHash                #-}
{-# LANGUAGE PatternSynonyms          #-}
{-# LANGUAGE Strict                   #-}
{-# LANGUAGE TypeFamilies             #-}
{-# LANGUAGE TypeOperators            #-}
{-# LANGUAGE UnboxedTuples            #-}
{-# LANGUAGE UndecidableInstances     #-}
{-# LANGUAGE UnliftedFFITypes         #-}
{-# LANGUAGE ViewPatterns             #-}
module Graphics.Vulkan.Ext.VK_ANDROID_native_buffer
       (-- * Vulkan extension: @VK_ANDROID_native_buffer@
        -- |
        --
        -- supported: @disabled@
        --
        -- Extension number: @11@
        VkNativeBufferANDROID(..), vkGetSwapchainGrallocUsageANDROID,
        vkAcquireImageANDROID, vkQueueSignalReleaseImageANDROID,
        VK_ANDROID_NATIVE_BUFFER_SPEC_VERSION,
        pattern VK_ANDROID_NATIVE_BUFFER_SPEC_VERSION,
        VK_ANDROID_NATIVE_BUFFER_NUMBER,
        pattern VK_ANDROID_NATIVE_BUFFER_NUMBER,
        VK_ANDROID_NATIVE_BUFFER_NAME,
        pattern VK_ANDROID_NATIVE_BUFFER_NAME,
        pattern VK_STRUCTURE_TYPE_NATIVE_BUFFER_ANDROID)
       where
import           Data.Int
import           Data.Void                        (Void)
import           Data.Word
import           Foreign.C.String                 (CString)
import           Foreign.C.Types                  (CChar (..), CFloat (..),
                                                   CInt (..), CSize (..),
                                                   CULong (..))
import           Foreign.Storable                 (Storable (..))
import           GHC.ForeignPtr                   (ForeignPtr (..),
                                                   ForeignPtrContents (..),
                                                   newForeignPtr_)
import           GHC.Prim
import           GHC.Ptr                          (Ptr (..))
import           GHC.Types                        (IO (..), Int (..))
import           Graphics.Vulkan.Base
import           Graphics.Vulkan.Common
import           Graphics.Vulkan.Core
import           Graphics.Vulkan.Marshal
import           Graphics.Vulkan.Marshal.Internal
import           Graphics.Vulkan.StructMembers
import           System.IO.Unsafe                 (unsafeDupablePerformIO)

data VkNativeBufferANDROID = VkNativeBufferANDROID## ByteArray##

instance Eq VkNativeBufferANDROID where
        (VkNativeBufferANDROID## a) == (VkNativeBufferANDROID## b)
          = EQ == cmpImmutableContent a b

        {-# INLINE (==) #-}

instance Ord VkNativeBufferANDROID where
        (VkNativeBufferANDROID## a) `compare` (VkNativeBufferANDROID## b)
          = cmpImmutableContent a b

        {-# INLINE compare #-}

instance Storable VkNativeBufferANDROID where
        sizeOf ~_ = #{size VkNativeBufferANDROID}

        {-# INLINE sizeOf #-}
        alignment ~_ = #{alignment VkNativeBufferANDROID}

        {-# INLINE alignment #-}
        peek (Ptr addr)
          | I## n <- sizeOf (undefined :: VkNativeBufferANDROID),
            I## a <- alignment (undefined :: VkNativeBufferANDROID) =
            IO
              (\ s ->
                 case newAlignedPinnedByteArray## n a s of
                     (## s1, mba ##) -> case copyAddrToByteArray## addr mba 0## n s1 of
                                          s2 -> case unsafeFreezeByteArray## mba s2 of
                                                    (## s3, ba ##) -> (## s3,
                                                                       VkNativeBufferANDROID## ba ##))

        {-# INLINE peek #-}
        poke (Ptr addr) (VkNativeBufferANDROID## ba)
          | I## n <- sizeOf (undefined :: VkNativeBufferANDROID) =
            IO (\ s -> (## copyByteArrayToAddr## ba 0## addr n s, () ##))

        {-# INLINE poke #-}

instance VulkanMarshal VkNativeBufferANDROID where
        {-# INLINE newVkData #-}
        newVkData f
          | I## n <- sizeOf (undefined :: VkNativeBufferANDROID),
            I## a <- alignment (undefined :: VkNativeBufferANDROID) =
            IO
              (\ s0 ->
                 case newAlignedPinnedByteArray## n a s0 of
                     (## s1, mba ##) -> case unsafeFreezeByteArray## mba s1 of
                                          (## s2, ba ##) -> case f (Ptr (byteArrayContents## ba)) of
                                                              IO k -> case k s2 of
                                                                          (## s3, () ##) -> (## s3,
                                                                                             VkNativeBufferANDROID##
                                                                                               ba ##))

        {-# INLINE unsafePtr #-}
        unsafePtr (VkNativeBufferANDROID## ba) = Ptr (byteArrayContents## ba)

        {-# INLINE fromForeignPtr #-}
        fromForeignPtr = fromForeignPtr## VkNativeBufferANDROID##

        {-# INLINE toForeignPtr #-}
        toForeignPtr (VkNativeBufferANDROID## ba)
          = do ForeignPtr addr (PlainForeignPtr r) <- newForeignPtr_
                                                        (Ptr (byteArrayContents## ba))
               IO
                 (\ s -> (## s, ForeignPtr addr (MallocPtr (unsafeCoerce## ba) r) ##))

        {-# INLINE toPlainForeignPtr #-}
        toPlainForeignPtr (VkNativeBufferANDROID## ba)
          = IO
              (\ s ->
                 (## s,
                    ForeignPtr (byteArrayContents## ba)
                      (PlainPtr (unsafeCoerce## ba)) ##))

        {-# INLINE touchVkData #-}
        touchVkData x@(VkNativeBufferANDROID## ba)
          = IO (\ s -> (## touch## x (touch## ba s), () ##))

instance {-# OVERLAPPING #-} HasVkSType VkNativeBufferANDROID where
        type VkSTypeMType VkNativeBufferANDROID = VkStructureType

        {-# NOINLINE vkSType #-}
        vkSType x
          = unsafeDupablePerformIO
              (peekByteOff (unsafePtr x) #{offset VkNativeBufferANDROID, sType})

        {-# INLINE vkSTypeByteOffset #-}
        vkSTypeByteOffset ~_
          = #{offset VkNativeBufferANDROID, sType}

        {-# INLINE readVkSType #-}
        readVkSType p
          = peekByteOff p #{offset VkNativeBufferANDROID, sType}

        {-# INLINE writeVkSType #-}
        writeVkSType p
          = pokeByteOff p #{offset VkNativeBufferANDROID, sType}

instance {-# OVERLAPPING #-} HasVkPNext VkNativeBufferANDROID where
        type VkPNextMType VkNativeBufferANDROID = Ptr Void

        {-# NOINLINE vkPNext #-}
        vkPNext x
          = unsafeDupablePerformIO
              (peekByteOff (unsafePtr x) #{offset VkNativeBufferANDROID, pNext})

        {-# INLINE vkPNextByteOffset #-}
        vkPNextByteOffset ~_
          = #{offset VkNativeBufferANDROID, pNext}

        {-# INLINE readVkPNext #-}
        readVkPNext p
          = peekByteOff p #{offset VkNativeBufferANDROID, pNext}

        {-# INLINE writeVkPNext #-}
        writeVkPNext p
          = pokeByteOff p #{offset VkNativeBufferANDROID, pNext}

instance {-# OVERLAPPING #-} HasVkHandle VkNativeBufferANDROID
         where
        type VkHandleMType VkNativeBufferANDROID = Ptr Void

        {-# NOINLINE vkHandle #-}
        vkHandle x
          = unsafeDupablePerformIO
              (peekByteOff (unsafePtr x) #{offset VkNativeBufferANDROID, handle})

        {-# INLINE vkHandleByteOffset #-}
        vkHandleByteOffset ~_
          = #{offset VkNativeBufferANDROID, handle}

        {-# INLINE readVkHandle #-}
        readVkHandle p
          = peekByteOff p #{offset VkNativeBufferANDROID, handle}

        {-# INLINE writeVkHandle #-}
        writeVkHandle p
          = pokeByteOff p #{offset VkNativeBufferANDROID, handle}

instance {-# OVERLAPPING #-} HasVkStride VkNativeBufferANDROID
         where
        type VkStrideMType VkNativeBufferANDROID = #{type int}

        {-# NOINLINE vkStride #-}
        vkStride x
          = unsafeDupablePerformIO
              (peekByteOff (unsafePtr x) #{offset VkNativeBufferANDROID, stride})

        {-# INLINE vkStrideByteOffset #-}
        vkStrideByteOffset ~_
          = #{offset VkNativeBufferANDROID, stride}

        {-# INLINE readVkStride #-}
        readVkStride p
          = peekByteOff p #{offset VkNativeBufferANDROID, stride}

        {-# INLINE writeVkStride #-}
        writeVkStride p
          = pokeByteOff p #{offset VkNativeBufferANDROID, stride}

instance {-# OVERLAPPING #-} HasVkFormat VkNativeBufferANDROID
         where
        type VkFormatMType VkNativeBufferANDROID = #{type int}

        {-# NOINLINE vkFormat #-}
        vkFormat x
          = unsafeDupablePerformIO
              (peekByteOff (unsafePtr x) #{offset VkNativeBufferANDROID, format})

        {-# INLINE vkFormatByteOffset #-}
        vkFormatByteOffset ~_
          = #{offset VkNativeBufferANDROID, format}

        {-# INLINE readVkFormat #-}
        readVkFormat p
          = peekByteOff p #{offset VkNativeBufferANDROID, format}

        {-# INLINE writeVkFormat #-}
        writeVkFormat p
          = pokeByteOff p #{offset VkNativeBufferANDROID, format}

instance {-# OVERLAPPING #-} HasVkUsage VkNativeBufferANDROID where
        type VkUsageMType VkNativeBufferANDROID = #{type int}

        {-# NOINLINE vkUsage #-}
        vkUsage x
          = unsafeDupablePerformIO
              (peekByteOff (unsafePtr x) #{offset VkNativeBufferANDROID, usage})

        {-# INLINE vkUsageByteOffset #-}
        vkUsageByteOffset ~_
          = #{offset VkNativeBufferANDROID, usage}

        {-# INLINE readVkUsage #-}
        readVkUsage p
          = peekByteOff p #{offset VkNativeBufferANDROID, usage}

        {-# INLINE writeVkUsage #-}
        writeVkUsage p
          = pokeByteOff p #{offset VkNativeBufferANDROID, usage}

instance Show VkNativeBufferANDROID where
        showsPrec d x
          = showString "VkNativeBufferANDROID {" .
              showString "vkSType = " .
                showsPrec d (vkSType x) .
                  showString ", " .
                    showString "vkPNext = " .
                      showsPrec d (vkPNext x) .
                        showString ", " .
                          showString "vkHandle = " .
                            showsPrec d (vkHandle x) .
                              showString ", " .
                                showString "vkStride = " .
                                  showsPrec d (vkStride x) .
                                    showString ", " .
                                      showString "vkFormat = " .
                                        showsPrec d (vkFormat x) .
                                          showString ", " .
                                            showString "vkUsage = " .
                                              showsPrec d (vkUsage x) . showChar '}'

-- | > VkResult vkGetSwapchainGrallocUsageANDROID
--   >     ( VkDevice device
--   >     , VkFormat format
--   >     , VkImageUsageFlags imageUsage
--   >     , int* grallocUsage
--   >     )
--
--   <https://www.khronos.org/registry/vulkan/specs/1.0/man/html/vkGetSwapchainGrallocUsageANDROID.html vkGetSwapchainGrallocUsageANDROID registry at www.khronos.org>
foreign import ccall unsafe "vkGetSwapchainGrallocUsageANDROID"
               vkGetSwapchainGrallocUsageANDROID ::
               VkDevice -- ^ device
                        ->
                 VkFormat -- ^ format
                          ->
                   VkImageUsageFlags -- ^ imageUsage
                                     -> Ptr #{type int} -- ^ grallocUsage
                                                                    -> IO VkResult

-- | > VkResult vkAcquireImageANDROID
--   >     ( VkDevice device
--   >     , VkImage image
--   >     , int nativeFenceFd
--   >     , VkSemaphore semaphore
--   >     , VkFence fence
--   >     )
--
--   <https://www.khronos.org/registry/vulkan/specs/1.0/man/html/vkAcquireImageANDROID.html vkAcquireImageANDROID registry at www.khronos.org>
foreign import ccall unsafe "vkAcquireImageANDROID"
               vkAcquireImageANDROID ::
               VkDevice -- ^ device
                        ->
                 VkImage -- ^ image
                         ->
                   #{type int} -> VkSemaphore -- ^ semaphore
                                                          -> VkFence -- ^ fence
                                                                     -> IO VkResult

-- | > VkResult vkQueueSignalReleaseImageANDROID
--   >     ( VkQueue queue
--   >     , uint32_t waitSemaphoreCount
--   >     , const VkSemaphore* pWaitSemaphores
--   >     , VkImage image
--   >     , int* pNativeFenceFd
--   >     )
--
--   <https://www.khronos.org/registry/vulkan/specs/1.0/man/html/vkQueueSignalReleaseImageANDROID.html vkQueueSignalReleaseImageANDROID registry at www.khronos.org>
foreign import ccall unsafe "vkQueueSignalReleaseImageANDROID"
               vkQueueSignalReleaseImageANDROID ::
               VkQueue -- ^ queue
                       ->
                 Data.Word.Word32 -- ^ waitSemaphoreCount
                                  ->
                   Ptr VkSemaphore -- ^ pWaitSemaphores
                                   ->
                     VkImage -- ^ image
                             -> Ptr #{type int} -- ^ pNativeFenceFd
                                                            -> IO VkResult

pattern VK_ANDROID_NATIVE_BUFFER_SPEC_VERSION :: (Num a, Eq a) => a

pattern VK_ANDROID_NATIVE_BUFFER_SPEC_VERSION = 5

type VK_ANDROID_NATIVE_BUFFER_SPEC_VERSION = 5

pattern VK_ANDROID_NATIVE_BUFFER_NUMBER :: (Num a, Eq a) => a

pattern VK_ANDROID_NATIVE_BUFFER_NUMBER = 11

type VK_ANDROID_NATIVE_BUFFER_NUMBER = 11

pattern VK_ANDROID_NATIVE_BUFFER_NAME :: CString

pattern VK_ANDROID_NATIVE_BUFFER_NAME <-
        (is_VK_ANDROID_NATIVE_BUFFER_NAME -> True)
  where VK_ANDROID_NATIVE_BUFFER_NAME
          = _VK_ANDROID_NATIVE_BUFFER_NAME

_VK_ANDROID_NATIVE_BUFFER_NAME :: CString

{-# INLINE _VK_ANDROID_NATIVE_BUFFER_NAME #-}
_VK_ANDROID_NATIVE_BUFFER_NAME
  = Ptr "VK_ANDROID_native_buffer\NUL"##

is_VK_ANDROID_NATIVE_BUFFER_NAME :: CString -> Bool

{-# INLINE is_VK_ANDROID_NATIVE_BUFFER_NAME #-}
is_VK_ANDROID_NATIVE_BUFFER_NAME
  = (_VK_ANDROID_NATIVE_BUFFER_NAME ==)

type VK_ANDROID_NATIVE_BUFFER_NAME = "VK_ANDROID_native_buffer"

pattern VK_STRUCTURE_TYPE_NATIVE_BUFFER_ANDROID :: VkStructureType

pattern VK_STRUCTURE_TYPE_NATIVE_BUFFER_ANDROID =
        VkStructureType 1000010000